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

local futureSaws = {}

function data.whenReloaded()
    futureSaws = {}
end

function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    self:delete()
    if self.id == "spawnSaws" then
        local speed = 750
        for i = #futureSaws, 1, -1 do
            local fS = futureSaws[i]
            props.MoverSaw.new(fS.x, -TileSize, fS.x, VH+TileSize, speed, true)
            table.remove(futureSaws, i)
        end
    elseif self.id == "deleteMovs" then 
        for _, p in ipairs(props.propList) do
            if getmetatable(p) == props.MoverSaw then
                p.isSinglePass = true
            end
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "FutSaws" then
        table.insert(futureSaws, obj)
    end
end

function data.MiscHandler(map) end

return data