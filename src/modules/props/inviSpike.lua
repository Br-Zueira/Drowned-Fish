local prop = require 'modules.props.prop'
local spike = require 'modules.props.spike'

-- Invisible spike that only appears when player is close
---@class InviSpike : Spike
---@field x number X coordinate of spike
---@field y number Y coordinate of spike
---@field radius number Radius in which player must be close in order to reveal the spike
---@field degrees? number Number in degrees in order to make a rotated invispike
---@field isInvisible boolean Makes the Invi of the InviSpike 
local InviSpike = {}
InviSpike.__index = InviSpike
setmetatable(InviSpike, spike)

-- Creates a new InviSpike
---@param x number X coordinate of spike
---@param y number Y coordinate of spike
---@param radius number Radius in which player must be close in order to reveal the spike
---@param d? number Degrees in order to make a rotated InviSpike
---@return InviSpike
function InviSpike.new(x, y, radius, d)
    local instance = spike.new(x, y, d)
    ---@cast instance InviSpike
    instance.isInvisible = true
    instance.radius = radius
    setmetatable(instance, InviSpike)
    return instance
end

-- Updates InviSpike
---@param player Player The player instance
function InviSpike:update(_, player)
    if prop.isPlayerInRadius(self, player, self.radius) then
        self.isInvisible = false
    end
end

return InviSpike