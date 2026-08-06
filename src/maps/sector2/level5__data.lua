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

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "movTile" then
            for _, p in ipairs(props.propList) do
                if p.isMovTile then
                    local offset = TileSize*3
                    p:delete()
                    props.Tile.new(p.x-offset, p.y)
                    return
                end
            end
        elseif self.id == "movSpring" then
            for _, p in ipairs(props.propList) do
                if p.isMovSpring then
                    local offset = TileSize*2
                    p:delete()
                    props.Spring.new(p.x-offset, p.y+TileSize)
                    return
                end
            end
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "MovTile" then
        local mT = props.Tile.new(obj.x, obj.y-TileSize)
        mT.isMovTile = true
    elseif obj.name == "MovSpring" then
       local mS = props.Spring.new(obj.x, obj.y)
       mS.isMovSpring = true
    end
end

function data.MiscHandler(map) end

return data