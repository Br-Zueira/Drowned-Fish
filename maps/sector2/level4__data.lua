local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local futureSaw

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded() end
function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        self:delete()
        props.MoverSaw.new(
            futureSaw.x,
            futureSaw.y,
            VW,
            futureSaw.y,
            futureSaw.properties.speed,
            true,
            true
        )
    end
end

function data.ObjHandler(obj)
    if obj.name == "FutureSaw" then
        futureSaw = obj
    elseif obj.name == "Trigger" then
        local p = obj.properties
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    end
end

function data.MiscHandler(map) end

return data