local Saw = require 'modules.props.saw'
local Moveable = require 'modules.props.moveable'

-- Saw that deslocates
---@class MoverSaw : Moveable
---@field x number X coordinate of mover saw
---@field y number Y coordinate of mover saw
---@field startX number Starting X coordinate of mover saw
---@field startY number Starting Y coordinate of mover saw
---@field endX number Ending X coordinate of mover saw
---@field endY number Ending X coordinate of mover saw
---@field speed number Speed of mover saw
---@field isOneWay boolean If true, the saw moves in a single direction
---@field isSinglePass boolean If true, the saw will be deleted after reaching the end point
local MoverSaw = {}
MoverSaw.__index = MoverSaw
setmetatable(MoverSaw, Moveable)

-- Creates a new MoverSaw
---@param x number Starting X coordinate of mover saw
---@param y number Starting Y coordinate of mover saw
---@param endX number Ending X coordinate of mover saw
---@param endY number Ending X coordinate of mover saw
---@param speed number Speed of mover saw
---@param isOneWay? boolean If true, the saw moves in a single direction
---@param isSinglePass? boolean If true, the saw will be deleted after reaching the end point
---@return MoverSaw
function MoverSaw.new(x, y, endX, endY, speed, isOneWay, isSinglePass)
    ---@type Prop
    local instance = Saw.new(x, y)
    Moveable.set(instance, x, y, endX, endY, speed, isOneWay, isSinglePass, Saw.update)
    ---@cast instance MoverSaw
    setmetatable(instance, MoverSaw)
    return instance
end

return MoverSaw