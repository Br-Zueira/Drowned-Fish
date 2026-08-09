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

function Spinner:update(dt, player)
    self.customUpdate(self, dt, player)
end

return Spinner