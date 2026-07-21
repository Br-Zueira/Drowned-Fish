local prop = require 'modules.props.prop'

-- Spike
local Spike = {}
Spike.__index = Spike
setmetatable(Spike, prop.Prop)

function Spike.new(x, y)
    local instance = prop.Prop.new(x, y - TileSize/2, TileSize, TileSize/2, { isImg=true, imgName='spike' })
    instance.isCross = true
    instance.type = 'Hazard'
    setmetatable(instance, Spike)
    return instance
end

return Spike