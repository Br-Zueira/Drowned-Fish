local world = require 'modules.world'
local assets = require 'modules.assets'

-- Class that defines a player and its behaviour
---@class Player
---@field x integer
---@field y integer
---@field velX integer
---@field velY integer
---@field width integer
---@field height integer
---@field deaths integer
---@field levelDeaths integer
---@field coyoteMax integer
---@field coyoteTimer integer
---@field jumpBufferMax integer
---@field jumpBufferTimer integer
---@field jumpCooldown boolean
---@field velSpeedDefault integer
---@field velSpeed integer
---@field gravityDefault integer
---@field gravity integer
---@field jumpForceDefault integer
---@field jumpForce integer
---@field boostedX integer
---@field frozenData table
---@field type 'Player'
local Player = {};
Player.__index = Player;

-- Player constructor
---@return Player
function Player.new()
    local instance = {
        x = 0, y = 0,
        velX = 0, velY = 0,
        width = TileSize, height = TileSize,
        deaths = 0, levelDeaths = 0,
        coyoteMax = 0.1, coyoteTimer = 0,
        jumpBufferMax = 0.1, jumpBufferTimer = 0,
        jumpCooldown = false,
        velSpeedDefault = 250, velSpeed = 250,
        gravityDefault = 6400, gravity = 6400,
        jumpForceDefault = -1300, jumpForce = -1300,
        type = 'Player',
        onGround = false,
        standingOnSpeedX = 0, standingOnSpeedY = 0,
        boostedX = 0,
        frozen = false, frozenTimer = 0, frozenData = {}
    }
    setmetatable(instance, Player)
    return instance
end

-- Player methods
function Player:draw()
    if self.isInvisible then return end
    love.graphics.draw(assets.images.player, self.x, self.y)
end

function Player.worldFilter(_, other)
    -- Pass through but detects colision and has "drag"
    if other.isCross then
        return 'cross'
    end

    -- Ignores completely colision
    if other.isTrigger then
        return nil
    end

    -- Default solid collision for walls/floors
    return 'slide'
end

-- Updates player each frame
---@param dt integer Delta time for each rendered frame
function Player:update(dt)
    -- Can freeze player at time, specially between level loading
    if self.frozen then
        -- Makes player invisible
        self.isInvisible = true

        -- Decreases timer down, while avoiding it to be 0
        self.frozenTimer = math.max(0, self.frozenTimer - dt)

        -- Switch between frozen conditions
        local fC = self.frozenData.frozenCondition
        if self.frozenTimer == 0 then
            if fC == 'nextLevel' then
                world.nextLevel(self)
            elseif fC == 'reload' then
                world.reload(self)
            elseif fC == 'loadMap' then
                world.loadMap(self.frozenData.sector, 1, self)
            end
            -- Unfreezes player
            self.frozen = false
            -- Makes player visible again
            self.isInvisible = false
        end
        return
    else
        -- Resets timer to standard
        self.frozenTimer = 0.5
    end

    -- Jump manager
    if love.keyboard.isDown('w') then
        if not self.jumpCooldown then
            self.jumpBufferTimer = self.jumpBufferMax
            self.jumpCooldown = true
        end
    else
        self.jumpCooldown = false -- Removes cooldown if key not pressed
    end

    -- Actual jump
    if (self.onGround or self.coyoteTimer > 0) and self.jumpBufferTimer > 0 then
        self.velY = self.jumpForce

        if self.standingOnSpeedY < 0 then
            self.velY = self.velY + self.standingOnSpeedY
        end

        self.onGround = false
        self.coyoteTimer = 0 -- Resets coyote timer to avoid double jump
        self.jumpBufferTimer = 0 -- Resets the buffer

        -- Jumping SFX
        assets.sfx.jump:clone():play()
    end

    -- Runs to left
    if love.keyboard.isDown('a') then
        self.velX = self.velX - self.velSpeed
    end

    -- Runs to right
    if love.keyboard.isDown('d') then
        self.velX = self.velX + self.velSpeed
    end

    if (love.keyboard.isDown('a') or love.keyboard.isDown('d')) and self.onGround then
        if not assets.sfx.steps:isPlaying() then
            assets.sfx.steps:play()
        end
    else
        assets.sfx.steps:stop()
    end

    -- Fall
    self.velY = self.velY + (self.gravity * dt)

    -- Expected coordinates for player to be at
    local moveX = self.velX
    if self.onGround then
        moveX = moveX + self.standingOnSpeedX
    end

    local expectedX = self.x + (moveX * dt)
    local expectedY = self.y + (self.velY * dt)

    -- Colision manager
    local realX, realY, cols, len = World:move(self, expectedX, expectedY, self.worldFilter)
    self.x = realX
    self.y = realY

    -- Avoid sliding, but keep booster momentum
    self.velX = self.boostedX
    local friction = 6
    self.boostedX = self.boostedX * math.max(0, 1 - (friction*dt))
    if math.abs(self.boostedX) < 0.1 then
        self.boostedX = 0
    end

    -- Loop through collisions to check if player is standing on the floor
    self.onGround = false
    self.bonked = false
    self.standingOnSpeedX = 0
    self.standingOnSpeedY = 0
    self.bonkedSpeedY = 0
    for i = 1, len do
        local col = cols[i] -- Colision of colisions
        local type = col.other.type
        if type == 'Hazard' then
            self:death()
            return
        elseif type == 'Goal' then
            -- Shows goal particles
            assets.particles.goalPS:setPosition(self.x, self.y)
            assets.particles.goalPS:emit(50)

            -- Plays the same SFX as portals
            assets.sfx.portal:clone():play()

            -- Freezes player
            self.frozenData.frozenCondition = 'nextLevel'
            self.frozen = true
            return
        end

        if col.normal.y == -1 then -- Hit something below player
            -- Speed of whatever is below player (0 if it doesnt have a speed)
            if col.other.velX then self.standingOnSpeedX = col.other.velX end
            if col.other.velY then self.standingOnSpeedY = col.other.velY end
            self.onGround = true -- Player is grounded
            self.coyoteTimer = self.coyoteMax -- Coyote Timer resets
            if type == 'Spring' then
                -- Plays the same SFX as jumping (only if not standing steel on spring)
                if self.velY > self.gravity*dt*1.1 then assets.sfx.jump:clone():play() end
                self.velY = -self.velY
            else
                -- Landing sfx (Needs to take gravity in account else sfx will play even with player standing still)
                if self.velY > self.gravity*dt then assets.sfx.landing:clone():play() end
                self.velY = 0
            end
        elseif col.normal.y == 1 then -- Hit a ceiling
            if col.other.velY then self.bonkedSpeedY = col.other.velY end -- Will be useful later as a death condition
            self.bonked = true -- Player bonked into a ceiling
            self.velY = 0 -- Head bonk, start falling instantly
        end
    end

    -- Query a 1-pixel high band directly above the player's head
    local topCols, topLen = World:queryRect(self.x + 2, self.y - 3, math.max(1, self.width - 4), 3)

    for i = 1, topLen do
        local item = topCols[i]
        if item ~= self then
            self.bonked = true
            if item.velY then
                self.bonkedSpeedY = item.velY
            end
        end
    end

    -- Coyote timer makes jumping feel smoother 
    -- Because it gives an extra "pixel" or time to jump
    if not self.onGround then
        self.coyoteTimer = math.max(0, self.coyoteTimer - dt) -- Timer counts down
    end

    -- Buffer that saves if player tries to jump before hitting ground,
    -- Making game feel more responsive
    self.jumpBufferTimer = math.max(0, self.jumpBufferTimer - dt)

    -- Kill conditions
    local OOB = (self.y > VH + TileSize) or (self.x > VW + TileSize) or (self.x < -TileSize)
    local crushed = self.onGround and (self.standingOnSpeedY < 0 or self.bonkedSpeedY > 0) and self.bonked
    if OOB or crushed then
        self:death()
    end
end

-- Kills player and reloads level, passing self as player instance
function Player:death()
    -- Avoids death while frozen
    if self.frozen then return end
    -- Shows death particles
    assets.particles.deathPS:setPosition(self.x, self.y)
    assets.particles.deathPS:emit(50)
    -- Plays death sfx
    assets.sfx.death:clone():play()
    -- Breaks momentum after death
    self.velX, self.velY, self.boostedX = 0, 0, 0
    -- Death counter
    self.deaths = self.deaths + 1
    self.levelDeaths = self.levelDeaths + 1
    -- Reloads map
    self.frozenData.frozenCondition = 'reload'
    self.frozen = true
    return
end

return Player