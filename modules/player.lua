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
        type = 'Player'
    }
    setmetatable(instance, Player)
    return instance
end

-- Player methods
function Player:draw()
    love.graphics.draw(assets.images.player, self.x, self.y)
end

local function worldFilter(_, other)
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
    -- Stops horizontal velocity to avoid sliding
    self.velX = 0

    -- Runs to left
    if love.keyboard.isDown('a') then
        self.velX = self.velX - self.velSpeed
    end

    -- Runs to right
    if love.keyboard.isDown('d') then
        self.velX = self.velX + self.velSpeed
    end

    -- Fall
    self.velY = self.velY + (self.gravity * dt)
    local expectedX = self.x + (self.velX * dt)
    local expectedY = self.y + (self.velY * dt)

    -- Crushed/Squeezed
    local isBeingLifted = false
    local didBonk = false

    -- Colision
    local realX, realY, cols, len = World:move(self, expectedX, expectedY, worldFilter)
    self.x = realX
    self.y = realY

    -- Loop through collisions to check if player is standing on the floor
    local onGround = false
    local standingOnSpeed = 0
    for i = 1, len do
        local col = cols[i] -- Colision of colisions

        local type = col.other.type
        if type == 'Hazard' then
            self:death()
            return
        elseif type == 'Goal' then
            world.nextLevel(self)
            return
        end

        if col.normal.y == -1 then -- Hit something below player
            standingOnSpeed = col.other.velY or 0 -- Speed of whatever is below player (0 if it doesnt have a speed)
            onGround = true -- Player is grounded
            self.coyoteTimer = self.coyoteMax -- Coyote Timer resets
            if standingOnSpeed < 0 then isBeingLifted = true end
        elseif col.normal.y == 1 then -- Hit a ceiling
            self.velY = 0 -- Head bonk, start falling instantly
            didBonk = true
        end
    end

    -- Kills player if they go out of screen or if they get squished
    if self.y > VH or (self.y < 0 and onGround) or self.x > VW or self.x < 0 or (isBeingLifted and didBonk) then
        self:death()
    end

    -- Coyote timer makes jumping feel smoother 
    -- Because it gives an extra "pixel" or time to jump
    if onGround then
        if self.velY >= 0 then
            self.velY = standingOnSpeed
        end
    else
        self.coyoteTimer = self.coyoteTimer - dt -- Timer counts down
    end
    if self.coyoteTimer < 0 then self.coyoteTimer = 0 end -- Timer can't be negative

    -- Buffer that saves if player tries to jump before hitting ground,
    -- Making game feel more responsive
    self.jumpBufferTimer = self.jumpBufferTimer - dt
    if self.jumpBufferTimer < 0 then self.jumpBufferTimer = 0 end

    -- Jump manager
    if love.keyboard.isDown('w') then
        if (onGround or self.coyoteTimer > 0) and self.jumpBufferTimer > 0 and not self.jumpCooldown then
            self.velY = self.jumpForce + standingOnSpeed -- The jump itself (conserves upwards momentum)
            self.coyoteTimer = 0 -- Resets coyote timer to avoid double jump
            self.jumpBufferTimer = 0 -- Resets the buffer
            self.jumpCooldown = true -- Locks jumping ability until user presses key again
            self.y = self.y + (standingOnSpeed*dt) - 2 -- Avoids clipping through a moving object
            World:update(self, self.x, self.y, self.width, self.height) -- Pushes the player 2px up to stop coliding with the saw
        else
            self.jumpBufferTimer = self.jumpBufferMax
        end
    else
        self.jumpCooldown = false -- Removes cooldown if key not pressed
    end
end

-- Kills player and reloads level, passing self as player instance
function Player:death()
    -- Death counter
    self.deaths = self.deaths + 1
    self.levelDeaths = self.levelDeaths + 1
    -- Reloads map
    world.reload(self)
end

return Player