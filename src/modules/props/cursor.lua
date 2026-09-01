local prop = require 'modules.props.prop'

-- Inheriters
---@class Cursor : Prop
---@field x number X coordinates of cursor
---@field y number Y coordinates of cursor
---@field isTrigger boolean Controls whether the cursor is a solid prop (false by default)
---@field layer number Rendering layer of cursor
local Cursor = {}
Cursor.__index = Cursor

-- Binds child to parent table
setmetatable(Cursor, prop.Prop)

-- Creates a cursor (simple square that serves as wall, floor or ceiling)
---@param x number X coordinates of cursor
---@param y number Y coordinates of cursor
---@param isSolid? boolean Controls whether the cursor is a solid prop (false by default)
---@return Cursor
function Cursor.new(x, y, isSolid)
    -- Adjusts Y coordinates because of Tiled object layer quirks
    y = y - TileSize

    -- Creates instance of parent metatable
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='cursor' })

    ---@cast instance Cursor
    -- Binds instance into cursor metatable
    setmetatable(instance, Cursor)

    -- Turns cursor into non solid by default
    instance.isTrigger = isSolid ~= true

    -- Rendering order
    instance.layer = 999

    return instance
end

function Cursor:update(dt, player)
end

return Cursor