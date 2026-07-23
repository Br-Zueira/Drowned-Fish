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
        self:delete()
        if self.id == "MoveSaws" then
            for i = #props.propList, 1, -1 do
                local p = props.propList[i]
                if p.isDesloc then
                    p:delete()
                    props.Saw.new(p.x, p.y - TileSize) -- "Moves" each saw two tiles up (two even with tilesize*1 because its buggy, yeah)
                end
            end
        elseif self.id == "MoveGoal" then
            for i = #props.propList, 1, -1 do
                local p = props.propList[i]
                if getmetatable(p) == props.FakeGoal then
                    p:delete()
                    props.Goal.new(self.x, self.y + TileSize)
                    break
                end
            end
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == 'Trigger' then
        local i = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(i, levelTrigger)
    elseif obj.name == 'FakeSaw' then
        local i = props.Portal.new(obj.x, obj.y, p.pair)
        i.renderTable = { isImg=true, imgName='saw'}
        i.degrees = 0
        function i:update(dt, player)
            props.Portal.update(self, dt, player)
            props.Saw.update(self, dt, player)
        end
    elseif obj.name == "FakePortal" then
        local i = props.Portal.new(obj.x, obj.y, 0)
        i.isTrigger = false
        i.type = 'Hazard'
    elseif obj.name == "DeslocSaw" then
        local i = props.Saw.new(obj.x, obj.y)
        i.isDesloc = true
    elseif obj.name == "FakeTile" then
        local i = props.Tile.new(obj.x, obj.y - TileSize)
        i.isCross = true
        i.type = 'Hazard'
    elseif obj.name == "FakeSpike" then
        local i = props.Spike.new(obj.x, obj.y)
        i.isCross = false
        i.type = 'Solid'
    end
end

function data.MiscHandler(map) end

return data