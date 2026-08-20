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

-- Receives the distance between player and tile and returns a ease value clamped between edge0 and edge1
---@param edge0 number The distance that defines 0%
---@param edge1 number The distance that defines 100%
---@param x number The distance between player and tile
local function ease(edge0, edge1, x)
    x = math.max(0, math.min(1, (x - edge0) / (edge1 - edge0)))
    return x*x*(3-2*x)
end

function Tile:update(_, player)
    -- Avoids crashes
    if not self.renderTable or not self.renderTable.rgba then return end

    -- Configs that can be easily changed
    local min = 0.5
    local max = 0.75
    local speedFactor = 1.25

    -- Puts sin (-1, 1) into range (0, 1)
    local rangedSin = (math.sin(love.timer.getTime() * speedFactor) + 1)/2

    -- Puts rangedSin (0, 1) into (min, max) range
    local greenChannel = rangedSin * (max - min) + min

    -- Puts a radius around tile that makes it glow brighter
    local dx = player.x - self.x
    local dy = player.y - self.y
    local distToPlayer = math.sqrt(dx*dx + dy*dy)

    -- Glows tile brighter using a ease in and out function if player is not frozen
    if not player.frozen then
        greenChannel = greenChannel + ease(TileSize*2, TileSize, distToPlayer)
    end

    -- Changes green channel
    self.renderTable.rgba[2] = greenChannel
end

return Tile