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

local futureSaw
local movSaw

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "futureSaw" then
            self:delete()
            props.MoverSaw.new(
                futureSaw.x, futureSaw.y,
                futureSaw.x, -TileSize,
                futureSaw.properties.speed,
                true, true
            )
        elseif self.id == "returnSaw" then
            self:delete()
            props.MoverSaw.new(
                futureSaw.x, -TileSize,
                futureSaw.x, futureSaw.y,
                futureSaw.properties.speed,
                true, true
            )
        elseif self.id == "spawnSaw" then
            local offset = TileSize/2
            self:delete()
            props.Saw.new(
                self.x + offset,
                self.y + TileSize
            )
        elseif self.id == "movSaw" then
            self:delete()
            movSaw:delete()
            movSaw = props.MoverSaw.new(
                movSaw.x, movSaw.y + TileSize*2,
                -TileSize, movSaw.y + TileSize,
                movSaw.speed,
                true, true
            )
        elseif self.id == "fakeTiles" then
            self:delete()
            for i = #props.propList, 1, -1 do
                local p = props.propList[i]
                if p.isFake then
                    p:delete()
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
    elseif obj.name == "FutureSaw" then
        futureSaw = obj
    elseif obj.name == "MovSaw" then
        movSaw = props.Saw.new(obj.x, obj.y)
        movSaw.speed = p.speed
    elseif obj.name == "FakeTile" then
        local t = props.Tile.new(obj.x, obj.y - TileSize)
        t.isFake = true
    end
end

function data.MiscHandler(map) end

return data