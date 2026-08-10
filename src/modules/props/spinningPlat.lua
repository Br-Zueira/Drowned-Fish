local tile = require 'modules.props.tile'
local spinner = require 'modules.props.spinner'

---@class SpinningPlat : Spinner
local SpinningPlat = {}
SpinningPlat.__index = SpinningPlat
setmetatable(SpinningPlat, spinner)

---@param x number X coordinate to reference spinning platform center
---@param y number Y coordinate to reference spinning platform center
---@param width? number Width, in tiles, of spinning platform
---@param height? number Height, in tiles, of spinning platform
---@param speed number Speed in which the platform rotates
---@param isCounterclockwise boolean Defines whether the spinning plat is spinning at counterclockwise
function SpinningPlat.new(x, y, width, height, speed, isCounterclockwise)
    local plat = {}
    y = y - TileSize
    width = width or 1
    height = height or 1
    local coreX, coreY = x, y
    if width % 2 == 1 then
        coreX = x + TileSize/2
    end
    if height % 2 == 1 then
        coreY = y + TileSize/2
    end
    for i = 1, width do
        for j = 1, height do
            local centerX = coreX + (i - (width+1)/2) * TileSize
            local centerY = coreY + (j - (height+1)/2) * TileSize
            local tileX = centerX - TileSize/2
            local tileY = centerY - TileSize/2
            local t = tile.new(tileX, tileY)
            spinner.set(t, coreX, coreY, speed, isCounterclockwise)
            table.insert(plat, t)
        end
    end
    return plat
end

return SpinningPlat