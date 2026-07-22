local world = require 'modules.world'

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
        jumpForceDefault = -1300, jumpForce = -1300
    }
    setmetatable(instance, Player)
    return instance
end

-- Player methods
function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
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

    -- Colision
    local realX, realY, cols, len = World:move(self, expectedX, expectedY, worldFilter)
    self.x = realX
    self.y = realY

    -- Loop through collisions to check if player is standing on the floor
    local onGround = false
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
            self.velY = 0
            onGround = true -- Player is grounded
            self.coyoteTimer = self.coyoteMax -- Coyote Timer resets
        elseif col.normal.y == 1 then -- Hit a ceiling
            self.velY = 0 -- Head bonk, start falling instantly
        end
    end

    -- Coyote timer makes jumping feel smoother 
    -- Because it gives an extra "pixel" or time to jump
    if not onGround then
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
            self.velY = self.jumpForce -- The jump itself
            self.coyoteTimer = 0 -- Resets coyote timer to avoid double jump
            self.jumpBufferTimer = 0 -- Resets the buffer
            self.jumpCooldown = true -- Locks jumping ability until user presses key again
        else
            self.jumpBufferTimer = self.jumpBufferMax
        end
    else
        self.jumpCooldown = false -- Removes cooldown if key not pressed
    end

    -- Kills player if they fall out of screen
    if self.y > VH then
        self:death()
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