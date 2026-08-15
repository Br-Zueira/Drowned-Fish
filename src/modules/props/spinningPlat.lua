local tile = require 'modules.props.tile'
local spinner = require 'modules.props.spinner'

---@class SpinningPlat : Spinner
---@field x number X coordinate to reference spinning platform center
---@field y number Y coordinate to reference spinning platform center
---@field width number Width, in tiles, of spinning platform
---@field height number Height, in tiles, of spinning platform
---@field speed number Speed in which the platform rotates
---@field isCounterclockwise boolean Defines whether the spinning plat is spinning at counterclockwise
local SpinningPlat = {}
SpinningPlat.__index = SpinningPlat
setmetatable(SpinningPlat, spinner)

-- Creates a new spinning platform
---@param x number X coordinate to reference spinning platform center
---@param y number Y coordinate to reference spinning platform center
---@param width? number Width, in tiles, of spinning platform
---@param height? number Height, in tiles, of spinning platform
---@param speed number Speed in which the platform rotates
---@param isCounterclockwise boolean Defines whether the spinning plat is spinning at counterclockwise
---@param customUpdate? function Custom update logic to run along with standard update
function SpinningPlat.new(x, y, width, height, speed, isCounterclockwise, customUpdate)
    -- Creates a reference to the whole platform if ever needed
    local plat = {}

    -- Usual adjust to compensate Tiled object and layout layer differences
    y = y - TileSize

    -- Dimensions in tiles (default is 1, 1)
    width = width or 1
    height = height or 1

    -- Calculates the exact central point of spin
    local coreX, coreY = x, y
    if width % 2 == 1 then
        coreX = x + TileSize/2
    end
    if height % 2 == 1 then
        coreY = y + TileSize/2
    end

    -- Creates each tile
    for i = 1, width do
        for j = 1, height do
            -- The tile center
            local centerX = coreX + (i - (width+1)/2) * TileSize
            local centerY = coreY + (j - (height+1)/2) * TileSize

            -- The actual tile coordinates (top-left instead of center)
            local tileX = centerX - TileSize/2
            local tileY = centerY - TileSize/2

            -- Tile instance (sets it as spinner and saves its reference) 
            local tileInstance = tile.new(tileX, tileY)
            spinner.set(tileInstance, coreX, coreY, speed, isCounterclockwise, customUpdate)
            table.insert(plat, tileInstance)
        end
    end

    -- Returns platform reference
    return plat
end

return SpinningPlat