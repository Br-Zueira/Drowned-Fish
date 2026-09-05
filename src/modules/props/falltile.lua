local prop = require 'modules.props.prop'
local tile = require 'modules.props.tile'
local moveable = require 'modules.props.moveable'

-- A tile which will go to a specific direction if player is in radius
---@class FallTile : Tile
---@field x number X coordinate of tile
---@field y number Y coordinate of tile
---@field radius number Radius in which the tile will move
---@field endX number X coordinate which tile will go to
---@field endY number Y coordinate which tile will go to
---@field speed? number Speed which the tile will move at
---@field isGrav boolean This makes the tile move at dynamic speed
---@field gravity? number Optional, custom gravity
local FallTile = {}
FallTile.__index = FallTile
setmetatable(FallTile, prop.Prop)

-- Creates a new tile which will go to a specific direction if player is in radius
---@param x number X coordinate of tile
---@param y number Y coordinate of tile
---@param radius number Radius in which the tile will move
---@param endX number X coordinate which tile will go to
---@param endY number Y coordinate which tile will go to
---@param isUp boolean Abstraction for tiles that go 100% up or 100% down
---@param speed? number Speed which the tile will move at
---@param gravity? number Optional custom gravity value
function FallTile.new(x, y, radius, endX, endY, isUp, speed, gravity)
    y = y - TileSize
    local t = tile.new(x, y)

    ---@cast t FallTile
    setmetatable(t, FallTile)

    t.radius = radius

    t.endX = endX or t.x
    t.endY = endY or (endX and t.y) or (isUp and -TileSize) or (VH + TileSize)

    t.speed = speed or 1
    if not speed then t.isGrav = true end

    t.gravity = gravity or 6400

    return t
end

-- Updates the FallTile, making it fall to a specific direction if player is close enough
---@param dt number Elapsed time between frames
---@param player Player Player instance
function FallTile:update(dt, player)
    tile.update(self, dt, player)
    if prop.isPlayerInRadius(self, player, self.radius) then
        self.y = self.y + TileSize
        moveable.set(
            self, self.x, self.y,
            self.endX, self.endY,
            self.speed, true, true,
            FallTile.afterUpdate
        )
    end
end

function FallTile:afterUpdate(dt, player)
    -- Standard tile updating
    tile.update(self, dt, player)

    -- Only applies the gravity effect if the falltile is gravity
    if not self.isGrav then return end

    -- Making a kind of terminal velocity
    self.speed = math.min(10000, self.speed + self.gravity * dt)
end

return FallTile