local prop = require 'modules.props.prop'
local spike = require 'modules.props.spike'

-- Invisible spike that only appears when player is close
---@class InviSpike : Prop
---@field x number X coordinate of spike
---@field y number Y coordinate of spike
---@field radius number Radius in which player must be close in order to reveal the spike
---@field degrees? number Number in degrees in order to make a rotated invispike
local InviSpike = {}
InviSpike.__index = InviSpike
setmetatable(InviSpike, prop.Prop)

-- Creates a new InviSpike
---@param x number X coordinate of spike
---@param y number Y coordinate of spike
---@param radius number Radius in which player must be close in order to reveal the spike
---@param d? number Number in degrees in order to make a rotated invispike
function InviSpike.new(x, y, radius, d)
    y = y - TileSize/2
    local instance = prop.Prop.new(x, y, TileSize, TileSize/2, { isImg=nil })
    instance.isCross = true
    instance.radius = radius
    instance.degrees = d or 0
    setmetatable(instance, InviSpike)
    return instance
end

function InviSpike:update(_, player)
    if prop.isPlayerInRadius(self, player, self.radius) then
        self:delete()
        local s = spike.new(self.x, self.y+TileSize/2)
        s.degrees = self.degrees
    end
end

return InviSpike