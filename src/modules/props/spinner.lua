local prop = require 'modules.props.prop'

---@class Spinner : Prop
---@field rotationX number
---@field rotationY number
---@field rotationSpeed number
---@field isCounterclockwise boolean
---@field customUpdate function
---@field degrees number
---@field radius number
---@field angle number
local Spinner = {}
Spinner.__index = Spinner
setmetatable(Spinner, prop.Prop)

-- Sets a props as a spinner
---@param instance Prop
---@param rotationX number
---@param rotationY number
---@param rotationSpeed number
---@param isCounterclockwise boolean
---@param customUpdate? function
function Spinner.set(instance, rotationX, rotationY, rotationSpeed, isCounterclockwise, customUpdate)
    setmetatable(instance, Spinner)
    ---@cast instance Spinner
    instance.rotationX = rotationX
    instance.rotationY = rotationY
    instance.rotationSpeed = rotationSpeed
    instance.isCounterclockwise = isCounterclockwise == true -- Converts nil into false
    instance.customUpdate = customUpdate or function() end
    instance.degrees = 0

    local coreX = instance.x + instance.sizeX / 2
    local coreY = instance.y + instance.sizeY / 2

    local dx = instance.rotationX - coreX
    local dy = instance.rotationY - coreY

    instance.radius = math.sqrt(dx*dx + dy*dy)
    instance.angle = math.atan2(dy, dx)
end

-- Returns cross for the player and ignores the rest
local function colFilter(_, o)
    if o.type == "Player" then
        return 'cross'
    end
    return nil
end

function Spinner:update(dt, player)
    -- Avoids bump.lua crashes
    if not World:hasItem(self) then return end

    -- Custom update logic, if any
    self.customUpdate(self, dt, player)

    -- Rotates clockwise or counterclockwise
    if self.isCounterclockwise then
        self.angle = self.angle - self.rotationSpeed * dt
    else
        self.angle = self.angle + self.rotationSpeed * dt
    end

    -- Target X and Y of prop
    local targetX = self.rotationX + math.cos(self.angle) * self.radius
    local targetY = self.rotationY + math.sin(self.angle) * self.radius

    -- Get current top-left before moving
    local currentX, currentY = self.x, self.y
    local coreX, coreY = currentX + self.sizeX / 2, currentY + self.sizeY / 2

    -- VelX and velY of spinner prop (deltaV divided by dt to turn it from px/frame to px/secs)
    self.velX, self.velY = (targetX - coreX)/dt, (targetY - coreY)/dt

    -- Moves prop through the world
    local realX, realY, cols, len = World:move(self, targetX - self.sizeX / 2, targetY - self.sizeY / 2, colFilter)
    self.x, self.y = realX, realY
    for i = 1, len do
        local col = cols[i]
        local o = col.other
        -- Corrects user position
        if col.normal.y == 1 and o.type == "Player" then
            local playerY = o.y - (self.velY*dt)
            o.x, o.y = World:move(o, o.x, playerY, player.worldFilter)
        end
    end

    -- Converts angle to degrees then save it
    self.degrees = math.deg(self.angle)
end

return Spinner