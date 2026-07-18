local bump = require 'libs.bump'
local sti = require 'libs.sti'

-- Player
-- Table with metadata to simulate object behaviour
local Player = {};
Player.__index = Player;

-- Player constructor
function Player.new(x, y)
    local instance = {
        x = x, y = y,
        velX = 0, velY = 0,
        width = 32, height = 64
    }
    setmetatable(instance, Player)
    World:add(instance, instance.x, instance.y, instance.width, instance.height)
    return instance
end

-- Player methods
function Player:draw()
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

function Player:update(dt)
    local velSpeed = 128
    local gravity = 64
    local jumpForce = -64

    -- Left
    if love.keyboard.isDown('a') then
        self.velX = self.velX - velSpeed * dt
    end
    
    -- Rigth
    if love.keyboard.isDown('d') then
        self.velX = self.velX + velSpeed * dt
    end

    -- Fall
    self.velY = self.velY + (gravity * dt)
    local expectedX = self.x + (self.velX * dt)
    local expectedY = self.y + (self.velY * dt)

    -- Colision
    local realX, realY, cols, len = World:move(self, expectedX, expectedY)
    self.x = realX
    self.y = realY

    -- Loop through collisions to check if we are standing on the floor
    local onGround = false
    for i = 1, len do
        local col = cols[i]

        if col.normal.y == -1 then -- Hit something below player
            self.velY = 0
            onGround = true -- Player is grounded
        elseif col.normal.y == 1 then -- Hit a ceiling
            self.velY = 0 -- Head bonk, start falling instantly
        end
    end

    -- Jump
    if onGround and love.keyboard.isDown('w') then
        self.velY = self.velY + jumpForce * dt
    end
end

-- Love standard implementations
function love.load()
    -- Window dimensions
    VW = love.graphics.getWidth()
    VH = love.graphics.getHeight()

    -- Create necessary objects
    World = bump.newWorld(32)
    PlayerInst = Player.new(VW/2, VH/2)
end

function love.update(dt)
    PlayerInst:update(dt)
end

function love.draw()
    -- Render player
    PlayerInst:draw()
end