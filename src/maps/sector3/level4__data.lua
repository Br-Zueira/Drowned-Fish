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

local futureLaser

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "spawnSaws" then
            self:delete()
            props.Saw.new(self.x - TileSize/2, self.y + TileSize)
            props.Saw.new(self.x + TileSize/2, self.y + TileSize)
        elseif self.id == "futureLaser" then
            self:delete()
            local l = props.Laser.new(
                futureLaser.x, futureLaser.y, 
                futureLaser.properties.group
            )

            l.y = l.y + TileSize
            props.Moveable.set(
                l,
                l.x, l.y,
                l.x, futureLaser.properties.endY,
                futureLaser.properties.speed, false, false
            )
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "MovLaser" then
        local l = props.Laser.new(obj.x, obj.y, p.group)
        l.y = l.y + TileSize
        props.Moveable.set(
            l,
            l.x, l.y,
            l.x, p.endY,
            p.speed, false, false
        )
    elseif obj.name == "FutureLaser" then
        futureLaser = obj
    end
end

function data.MiscHandler(map) end

return data