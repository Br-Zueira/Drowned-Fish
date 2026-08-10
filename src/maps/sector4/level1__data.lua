local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded() end
function data.update() end
function data.ObjHandler(obj)
    if obj.name == "SpinningPlat" then
        obj.y = obj.y - TileSize
        local p = obj.properties
        local width = p.width or 1
        local height = p.height or 1
        local coreX, coreY = obj.x, obj.y
        if width % 2 == 1 then
            coreX = obj.x + TileSize/2
        end
        if height % 2 == 1 then
            coreY = obj.y + TileSize/2
        end
        for i = 1, width do
            for j = 1, height do
                local centerX = coreX + (i - (width+1)/2) * TileSize
                local centerY = coreY + (j - (height+1)/2) * TileSize
                local tileX = centerX - TileSize/2
                local tileY = centerY - TileSize/2
                local t = props.Tile.new(tileX, tileY)
                props.Spinner.set(t, coreX, coreY, p.speed, p.isAntiClock)
            end
        end
    end
end
function data.MiscHandler(map) end

return data