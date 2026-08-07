local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded() end

function data.whenReloaded()end

function data.update() end

function data.ObjHandler(obj)
    if obj.name == "MovPlat" then
        local t = props.Tile.new(obj.x, obj.y - TileSize)
        local height = VH - TileSize*7
        props.Moveable.set(t, t.x, t.y, t.x, height, obj.properties.speed)
    end
end

function data.MiscHandler(map) end

return data