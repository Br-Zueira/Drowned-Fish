local props = require 'modules.props'
local assets = require 'modules.assets'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded() end
function data.whenReloaded() end
function data.update() end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == 'Moveable' then
        local i = props.Tile.new(obj.x, obj.y)
        props.Moveable.set(i, i.x, i.y, p.endX, p.endY, p.speed, p.isOneWay)
    end
end

function data.MiscHandler(map) end

return data