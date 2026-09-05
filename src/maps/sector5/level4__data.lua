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

-- TODO: Make tiles that fall (down or up) after the "buffer overflow" and when player is near

local canOverflow = false

function data.whenReloaded(player)
    canOverflow = false
end

function data.update(dt, player)
    if canOverflow then
        player.levelDeaths = player.levelDeaths + math.ceil(100000000*dt)
    end
end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    self:delete()
    if self.id == "overflow" then
        canOverflow = true
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