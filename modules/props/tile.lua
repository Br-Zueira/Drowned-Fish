local prop = require 'modules.props.prop'

-- Inheriters
local Tile = {}
Tile.__index = Tile

-- Binds child to parent table
setmetatable(Tile, prop.Prop)

-- Creates a tile (simple square that serves as wall, floor or ceiling)
function Tile.new(x, y)
    -- Creates instance of parent metatable
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='tile'})

    -- Binds instance into tile metatable
    setmetatable(instance, Tile)
    return instance
end

return Tile