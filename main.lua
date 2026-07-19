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
        width = TileSize, height = TileSize * 2,
        deaths = 0
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
    -- Values for character physics
    local velSpeed = 200
    local gravity = 6400
    local jumpForce = -1200

    -- Stops horizontal velocity to avoid sliding
    self.velX = 0

    -- Left
    if love.keyboard.isDown('a') then
        self.velX = self.velX - velSpeed
    end

    -- Right
    if love.keyboard.isDown('d') then
        self.velX = self.velX + velSpeed
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
        self.velY = self.velY + jumpForce
    end

    if self.y > VH then
        self:death(VW/2, VH/2)
    end
end

function Player:death(x, y)
    -- Respawn
    self.x = x
    self.y = y
    self.velX = 0
    self.velY = 0

    -- Updates position in physics evaluator
    World:update(self, self.x, self.y, self.width, self.height)

    -- Death counter
    self.deaths = self.deaths + 1
end

-- Love standard implementations
function love.load()
    -- Window dimensions
    VW = love.graphics.getWidth()
    VH = love.graphics.getHeight()

    -- Tiling
    TileSize = 32

    -- Create necessary objects
    World = bump.newWorld(TileSize)
    PlayerInst = Player.new(VW/2, VH/2)
    COLLIDER_TEST_REMOVE_LATER = { x=VW/6, y=VH/2, sizeX=VW*(2/3), sizeY=VH/2 }
    World:add(COLLIDER_TEST_REMOVE_LATER, COLLIDER_TEST_REMOVE_LATER.x, COLLIDER_TEST_REMOVE_LATER.y, COLLIDER_TEST_REMOVE_LATER.sizeX, COLLIDER_TEST_REMOVE_LATER.sizeY)
end

function love.update(dt)
    PlayerInst:update(dt)
end

function love.draw()
    -- Render player
    PlayerInst:draw()

    -- Render death counter
    love.graphics.print('Deaths: ' .. PlayerInst.deaths, 10, 10, 0, 2, 2)

    -- Test prop
    love.graphics.rectangle('fill', COLLIDER_TEST_REMOVE_LATER.x, COLLIDER_TEST_REMOVE_LATER.y, COLLIDER_TEST_REMOVE_LATER.sizeX, COLLIDER_TEST_REMOVE_LATER.sizeY)
end