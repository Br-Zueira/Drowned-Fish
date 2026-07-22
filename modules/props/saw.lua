local prop = require 'modules.props.prop'

-- Saw
---@class Saw : Prop
---@field x number X coordinate of saw
---@field y number Y coordinate of saw
local Saw = {}
Saw.__index = Saw
setmetatable(Saw, prop.Prop)

-- Creates a new saw
---@param x number X coordinate of saw
---@param y number Y coordinate of saw
function Saw.new(x, y)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='saw' })
    instance.degrees = 0
    instance.isCross = true
    instance.type = 'Hazard'
    setmetatable(instance, prop.Saw)
    return instance
end

function Saw:update(dt)
    self.degrees = (self.degrees + (720*dt)) % 360
end

return Saw