local prop = require 'modules.props.prop'

-- Trigger (always managed by the level itself as they always do different things)
local Trigger = {}
Trigger.__index = Trigger
setmetatable(Trigger, prop.Prop)

function Trigger.new(x, y, id, radius)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=nil })
    instance.isTrigger = true
    instance.id = id
    instance.radius = radius
    setmetatable(instance, Trigger)
    return instance
end

return Trigger