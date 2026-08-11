local prop = require 'modules.props.prop'

---@class Spinner : Prop
---@field rotationX number
---@field rotationY number
---@field rotationSpeed number
---@field isCounterclockwise boolean
---@field customUpdate function
---@field degrees number
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
end

-- Returns cross for the player and ignores the rest
local function colFilter(_, o)
    if o.type == "Player" then
        return 'cross'
    end
    return nil
end

function Spinner:update(dt, player)
    -- Custom update logic, if any
    self.customUpdate(self, dt, player)
    -- Center of prop
    local coreX, coreY = self.x + self.sizeX / 2, self.y + self.sizeY / 2

    -- Distance between rotation point and center of prop (X and Y)
    local dX, dY = coreX - self.rotationX, coreY - self.rotationY

    -- Combined distance between both
    local dist = math.sqrt(dX*dX + dY*dY)

    -- Angle (in radians)
    local angle = math.atan2(dY, dX)

    -- Rotates clockwise or counterclockwise
    if self.isCounterclockwise then
        angle = angle - self.rotationSpeed * dt
    else
        angle = angle + self.rotationSpeed * dt
    end

    -- Target X and Y of prop
    local targetX = self.rotationX + math.cos(angle) * dist
    local targetY = self.rotationY + math.sin(angle) * dist

    -- VelX and velY of spinner prop (deltaV divided by dt to turn it from px/frame to px/secs)
    self.velX, self.velY = (targetX - coreX)/dt, (targetY - coreY)/dt

    -- Avoids bump.lua crashed
    if not World:hasItem(self) then return end

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
    self.degrees = math.deg(angle)
end

return Spinner