local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Cursor idea: Cursor that brings saw while player is at the gap, then a portal reveals itself right at the last second

-- Custom, single level data
local data = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded(player) end
function data.update(dt, player) end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    self:delete()
    if self.id == 'spawnCursor' then
        props.Cursor.new(self.x, self.y)
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    end
end

function data.MiscHandler(map) end

return data