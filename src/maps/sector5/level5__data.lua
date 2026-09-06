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

local cursor = {}

function data.whenReloaded(player)
    cursor = {}
end

function data.update(dt, player)
    cursor:goto(player, { isFixedTime=false, speed=00 })
end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    self:delete()
    if self.id == "spawnSaw" then
        props.MoverSaw.new(self.x, VH+TileSize, self.x, -TileSize, 2000, true, true)
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Cursor" then
        cursor = props.Cursor.new(obj.x, obj.y)
        cursor.type = 'Hazard'
    elseif obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    end
end

function data.MiscHandler(map) end

return data