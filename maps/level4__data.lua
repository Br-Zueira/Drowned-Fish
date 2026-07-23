local props = require 'modules.props'
local assets = require 'modules.assets'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded() end
function data.whenReloaded() end
function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        self:delete()
        props.MoverSaw.new(608, 672, 608, 0, 100, true)
        local fake = props.MoverSaw.new(672, 672, 672, 0, 100, true)
        fake.type = 'Solid'
        fake.isCross = false
        fake.velY = -100
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == 'Trigger' then
        local i = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(i, levelTrigger)
    end
end

function data.MiscHandler(map) end

return data