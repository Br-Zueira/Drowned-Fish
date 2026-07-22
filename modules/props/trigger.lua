local prop = require 'modules.props.prop'

-- Trigger (always managed by the level itself as they always do different things)
---@class Trigger : Prop
---@field x number X coordinates of trigger
---@field y number Y coordinates of trigger
---@field id string Id of each trigger
---@field radius number Detection radius
local Trigger = {}
Trigger.__index = Trigger
setmetatable(Trigger, prop.Prop)

-- Creates a new trigger
---@param x number X coordinates of trigger
---@param y number Y coordinates of trigger
---@param id string Id of each trigger
---@param radius number Detection radius
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