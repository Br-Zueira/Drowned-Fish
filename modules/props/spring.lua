local prop = require 'modules.props.prop'

-- Spring that makes player bounce
---@class Spring : Prop
---@field type 'Spring'
local Spring = {}
Spring.__index = Spring
setmetatable(Spring, prop.Prop)

-- Creates new spring
---@param x number X coordinates of spring
---@param y number Y coordinates of spring
function Spring.new(x, y)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='spring'})
    setmetatable(instance, Spring)
    ---@cast instance Spring
    instance.type = 'Spring'
    return instance
end

return Spring