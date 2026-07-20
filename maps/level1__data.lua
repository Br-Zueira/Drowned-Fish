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

customProps.InviSpike = {}
customProps.InviSpike.__index = customProps.InviSpike
setmetatable(customProps.InviSpike, props.Prop)

function customProps.InviSpike.new(x, y, radius)
    y = y - TileSize/2
    local instance = props.Prop.new(x, y, TileSize, TileSize/2, { isImg=nil })
    instance.radius = radius
    setmetatable(instance, customProps.InviSpike)
    return instance
end

function customProps.InviSpike:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        self:delete()
        props.Spike.new(self.x, self.y+TileSize/2)
    end
end

-- O is object
function customProps.handler(o)
    local n = o.name
    local p = o.properties
    if n == 'FakeGoal' then
        customProps.FakeGoal.new(o.x, o.y, p.newX, p.newY, p.radius)
    elseif n == 'InviSpike' then
        customProps.InviSpike.new(o.x, o.y, p.radius)
    end
end
return customProps