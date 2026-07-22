local prop = require 'modules.props.prop'
local spike = require 'modules.props.spike'

local InviSpike = {}
InviSpike.__index = InviSpike
setmetatable(InviSpike, prop.Prop)

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