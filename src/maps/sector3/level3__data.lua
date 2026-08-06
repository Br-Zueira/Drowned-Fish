local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local futureSaw
local fallSaws = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded()
    fallSaws = {}
end

function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "movSaw" then
            self:delete()
            for i = #props.propList, 1, -1 do
                local prop = props.propList[i]
                if prop.isMov then
                    prop:delete()
                    local offset = TileSize*3
                    props.Saw.new(prop.x - offset, prop.y + TileSize)
                end
            end
        elseif self.id == "futureSaw" then
            self:delete()
            props.MoverSaw.new(
                futureSaw.x, futureSaw.y + TileSize,
                VW+TileSize, futureSaw.y,
                futureSaw.properties.speed,
                true, true
            )
        elseif self.id == "fallSaws" then
            self:delete()
            for _, prop in ipairs(fallSaws) do
                props.MoverSaw.new(prop.x, prop.y, prop.x, TileSize, 1000, true, true)
            end
            fallSaws = {}
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "MovSaw" then
        local s = props.Saw.new(obj.x, obj.y)
        s.isMov = true
    elseif obj.name == "FutureSaw" then
        futureSaw = obj
    elseif obj.name == "FallSaw" then
        table.insert(fallSaws, obj)
    end
end

function data.MiscHandler(map) end

return data