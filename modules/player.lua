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
        boostedX = 0
    }
    setmetatable(instance, Player)
    return instance
end

-- Player methods
function Player:draw()
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
    -- Jump manager
    if love.keyboard.isDown('w') then
        if not self.jumpCooldown then
            self.jumpBufferTimer = self.jumpBufferMax
            self.jumpCooldown = true
        end
    else
        self.jumpCooldown = false -- Removes cooldown if key not pressed
        self.jumpBufferTimer = math.max(0, self.jumpBufferTimer - dt)
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
    end

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
    self.standingOnSpeedX = 0
    self.standingOnSpeedY = 0
    for i = 1, len do
        local col = cols[i] -- Colision of colisions
        if love.keyboard.isDown("n") then return end
        local type = col.other.type
        if type == 'Hazard' then
            self:death()
            return
        elseif type == 'Goal' then
            world.nextLevel(self)
            return
        end

        if col.normal.y == -1 then -- Hit something below player
            self.standingOnSpeedX = col.other.velX or 0
            self.standingOnSpeedY = col.other.velY or 0 -- Speed of whatever is below player (0 if it doesnt have a speed)
            self.onGround = true -- Player is grounded
            self.coyoteTimer = self.coyoteMax -- Coyote Timer resets
            if type == 'Spring' then
                self.velY = -self.velY
                return
            else
                self.velY = 0
            end
        elseif col.normal.y == 1 then -- Hit a ceiling
            self.velY = 0 -- Head bonk, start falling instantly
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

    -- Kills player if they go out of screen
    if self.y > VH or self.x > VW + TileSize or self.x < -TileSize then
        self:death()
    end
end

-- Kills player and reloads level, passing self as player instance
function Player:death()
    -- Breaks momentum after death
    self.velX, self.velY, self.boostedX = 0, 0, 0
    -- Death counter
    self.deaths = self.deaths + 1
    self.levelDeaths = self.levelDeaths + 1
    -- Reloads map
    world.reload(self)
end

return Player