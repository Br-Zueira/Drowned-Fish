local prop = require 'modules.props.prop'

-- Inheriters
---@class Tile : Prop
---@field x number X coordinates of tile
---@field y number Y coordinates of tile
local Tile = {}
Tile.__index = Tile

-- Binds child to parent table
setmetatable(Tile, prop.Prop)

-- Creates a tile (simple square that serves as wall, floor or ceiling)
---@param x number X coordinates of tile
---@param y number Y coordinates of tile
---@return Tile
function Tile.new(x, y)
    -- Creates instance of parent metatable
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=false, rgba={0, 1, 0, 0.75} })

    ---@cast instance Tile
    -- Binds instance into tile metatable
    setmetatable(instance, Tile)
    return instance
end

function Tile:update()
    -- Avoids crashed
    if not self.renderTable or not self.renderTable.rgba then return end

    -- Configs that can be easily changed
    local min = 0.5
    local max = 0.75
    local speedFactor = 1.25

    -- Puts sin (-1, 1) into range (0, 1)
    local rangedSin = (math.sin(love.timer.getTime() * speedFactor) + 1)/2

    -- Puts rangedSin (0, 1) into (min, max) range
    local greenChannel = rangedSin * (max - min) + min

    -- Changes green channel
    self.renderTable.rgba[2] = greenChannel
end

return Tile