local prop = require 'modules.props.prop'

-- Spike
---@class Spike : Prop
---@field x number X coordinate of spike
---@field y number Y coordinate of spike
---@field isCross true Makes player able of actually dying to spike
---@field type 'Hazard' Makes player die to spike
---@field degrees? number Defined rotation of spike in order to make rotated spikes
local Spike = {}
Spike.__index = Spike
setmetatable(Spike, prop.Prop)

-- Creates a new spike
---@param x number X coordinate of spike
---@param y number Y coordinate of spike
---@param d? number Rotation, in degrees, of spike
---@return Spike
function Spike.new(x, y, d)
    local instance = prop.Prop.new(x, y - TileSize/2, TileSize, TileSize/2, { isImg=true, imgName='spike' })
    ---@cast instance Spike
    instance.degrees = d or 0
    instance.isCross = true
    instance.type = 'Hazard'
    setmetatable(instance, Spike)
    return instance
end

return Spike