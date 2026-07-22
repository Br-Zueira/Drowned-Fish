local prop = require 'modules.props.prop'

-- Spike
---@class Spike : Prop
---@field x number X coordinate of spike
---@field y number Y coordinate of spike
local Spike = {}
Spike.__index = Spike
setmetatable(Spike, prop.Prop)

-- Creates a new spike
---@param x number X coordinate of spike
---@param y number Y coordinate of spike
function Spike.new(x, y)
    local instance = prop.Prop.new(x, y - TileSize/2, TileSize, TileSize/2, { isImg=true, imgName='spike' })
    instance.isCross = true
    instance.type = 'Hazard'
    setmetatable(instance, Spike)
    return instance
end

return Spike