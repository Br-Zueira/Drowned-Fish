local props = require 'modules.props'

local customProps = {}

-- Fake goal that moves when player is close
customProps.FakeGoal = {}
customProps.FakeGoal.__index = customProps.FakeGoal
setmetatable(customProps.FakeGoal, props.Prop)

function customProps.FakeGoal.new(x, y, newX, newY, radius)
    y = y - TileSize
    local instance = props.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='goal' })
    instance.newX = newX
    instance.newY = newY
    instance.radius = radius
    setmetatable(instance, customProps.FakeGoal)
    return instance
end

function customProps.FakeGoal:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        props.Goal.new(self.newX, self.newY)
        self:delete()
    end
end


function customProps.handler(obj)
    local ppt = obj.properties
    if obj.name == 'FakeGoal' then
        customProps.FakeGoal.new(obj.x, obj.y, ppt.newX, ppt.newY, ppt.radius)
    end
end
return customProps