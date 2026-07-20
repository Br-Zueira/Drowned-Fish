local world = require 'modules.world'

-- Table with metadata to simulate object behaviour
local Player = {};
Player.__index = Player;

-- Player constructor
function Player.new()
    local instance = {
        spawnX = 0, spawnY = 0,
        x = 0, y = 0,
        velX = 0, velY = 0,
        width = TileSize, height = TileSize * 2,
        deaths = 0, levelDeaths = 0,
        coyoteMax = 0.1, coyoteTimer = 0
    }
    setmetatable(instance, Player)
    World:add(instance, instance.x, instance.y, instance.width, instance.height)
    return instance
end

-- Player methods
function Player:draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end

local function worldFilter(item, other)
    -- If 'other' is a trigger zone or trap trigger
    if other.isTrigger then
        return 'cross'
    end

    -- Default solid collision for walls/floors
    return 'slide' 
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
    local realX, realY, cols, len = World:move(self, expectedX, expectedY, worldFilter)
    self.x = realX
    self.y = realY

    -- Loop through collisions to check if we are standing on the floor
    local onGround = false
    for i = 1, len do
        local col = cols[i]

        if col.normal.y == -1 then -- Hit something below player
            self.velY = 0
            onGround = true -- Player is grounded
            self.coyoteTimer = self.coyoteMax
        elseif col.normal.y == 1 then -- Hit a ceiling
            self.velY = 0 -- Head bonk, start falling instantly
        end
    end

    if not onGround then
        self.coyoteTimer = self.coyoteTimer - dt
    end
    if self.coyoteTimer < 0 then self.coyoteTimer = 0 end

    -- Jump
    if (onGround or self.coyoteTimer > 0) and love.keyboard.isDown('w') then
        self.velY = self.velY + jumpForce
        self.coyoteTimer = 0
    end

    if self.y > VH then
        self:death()
    end
end

function Player:death()
    -- Death counter
    self.deaths = self.deaths + 1
    -- Reloads map
    world.reload(self)
end

return Player