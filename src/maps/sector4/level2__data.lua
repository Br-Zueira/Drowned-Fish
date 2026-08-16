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

local spinPoint = {}
local sP = {}

function data.whenReloaded()
    spinPoint = {}
    sP = {}
end

function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        self:delete()
        if self.id == "speedup" then
            spinPoint.speed = spinPoint.speed * 2
            for _, tile in ipairs(sP) do
                tile.rotationSpeed = 8
                tile.isCounterclockwise = not tile.isCounterclockwise
            end
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "MovSpinningPlat" then
        spinPoint = {}
        sP = props.SpinningPlat.new(
            obj.x, obj.y,
            p.width, p.height,
            p.rotationSpeed, p.isCounterclockwise,
            function(self)
                self.rotationX = spinPoint.x
                self.rotationY = spinPoint.y
            end
        )
        spinPoint = props.Prop.new(sP[1].rotationX, sP[1].rotationY, TileSize/2, TileSize/2, { isImg=nil })
        spinPoint.isTrigger = true
        props.Moveable.set(spinPoint, spinPoint.x, spinPoint.y, spinPoint.x, TileSize*6, p.speed, false, false)
    elseif obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "FakeMoverSaw" then
        local s = props.MoverSaw.new(obj.x, obj.y, p.endX, p.endY, p.speed, p.isOneWay, p.isSinglePass)
        s.type = "Solid"
        s.isCross = false
    elseif obj.name == "DeadlyTile" then
        obj.y = obj.y - TileSize
        local t = props.Tile.new(obj.x, obj.y)
        t.type = "Hazard"
        t.isCross = true
    end
end

function data.MiscHandler(map) end

return data