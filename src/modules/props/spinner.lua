local prop = require 'modules.props.prop'

local Spinner = {}
Spinner.__index = Spinner
setmetatable(Spinner, prop.Prop)

function Spinner.set(instance, rotationX, rotationY, rotationSpeed, isAntiClock, customUpdate)
    setmetatable(instance, Spinner)
    instance.rotationX = rotationX
    instance.rotationY = rotationY
    instance.rotationSpeed = rotationSpeed
    instance.isAntiClock = isAntiClock == true -- Converts nil into false
    instance.customUpdate = customUpdate or function() end
    instance.degrees = 0
end

local function colFilter(other)
    if other.type == "Player" then
        return 'cross'
    end
    return nil
end

function Spinner:update(dt, player)
    self.customUpdate(self, dt, player)
    local coreX, coreY = self.x + self.sizeX / 2, self.y + self.sizeY / 2
    local dX, dY = coreX - self.rotationX, coreY - self.rotationY
    local dist = math.sqrt(dX*dX + dY*dY)
    local angle = math.atan2(dY, dX)
    angle = angle + self.rotationSpeed * dt

    local targetX = self.rotationX + math.cos(angle) * dist
    local targetY = self.rotationY + math.sin(angle) * dist

    self.velX, self.velY = (targetX - coreX)/dt, (targetY - coreY)/dt

    local realX, realY, cols, len = World:move(self, targetX - self.sizeX / 2, targetY - self.sizeY / 2, colFilter)
    self.x, self.y = realX, realY
    for i = 1, len do
        local col = cols[i]
        local o = col.other
        if col.normal.y == 1 and o.type == "Player" then
            local playerY = o.y - (self.velY*dt)
            o.x, o.y = World:move(o, o.x, playerY, player.worldFilter)
        end
    end
end

return Spinner