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
        local t = props.Tile.new(obj.x, obj.y)
        props.Spinner.set(t, t.x + TileSize*2, t.y + TileSize/2, obj.properties.speed)
    end
end
function data.MiscHandler(map) end

return data