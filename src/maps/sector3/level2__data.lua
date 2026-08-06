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

local timer
local canStart = false

local futureSaw
local fakePlat
local truePlat
local spawnPlat

function data.whenReloaded()
    timer = 5
    canStart = false
end

function data.update(dt)
    if canStart then
        timer = math.max(0, timer - dt)
        if timer == 0 and fakePlat then
            props.MoverSaw.new(
                fakePlat.x, fakePlat.y,
                -TileSize, fakePlat.y,
                fakePlat.properties.speed,
                true, true
            )
            fakePlat = nil
            timer = 5
            return
        end
        if timer == 0 and not fakePlat and truePlat then
            local p = props.MoverSaw.new(
                truePlat.x, truePlat.y,
                -TileSize, truePlat.y,
                truePlat.properties.speed,
                true, true
            )
            p.type = "Solid"
            p.isCross = false
            truePlat = nil
            return
        end
    end
end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "futureSaw" then
            self:delete()
            local s = props.MoverSaw.new(
                futureSaw.x, futureSaw.y,
                VW + TileSize, futureSaw.y,
                futureSaw.properties.speed,
                true, true
            )
            s.type = "Solid"
            s.isCross = false
            canStart = true

            props.Tile.new(spawnPlat.x - TileSize, spawnPlat.y)
            props.Tile.new(spawnPlat.x, spawnPlat.y)
            props.Tile.new(spawnPlat.x + TileSize, spawnPlat.y)
        end
    end
end

local function updtT(self)
    if self.x < TileSize*20 then
        self.endX = VW+TileSize
        self.speed = 500
    end
end

local function updtS(self)
    if self.x < TileSize*12 then
        self.endX = TileSize*12
        self.endY = 0
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "MovSpring" then
        local mS = props.Spring.new(obj.x, obj.y)
        local mT = props.Tile.new(obj.x, obj.y)
        props.Moveable.set(mS, mS.x, mS.y, -TileSize, mS.y, p.speed, true, true, updtS)
        props.Moveable.set(mT, mT.x, mT.y, -TileSize, mT.y, p.speed, true, true, updtT)
    elseif obj.name == "FutureSaw" then
        futureSaw = obj
    elseif obj.name == "FakePlat" then
        fakePlat = obj
    elseif obj.name == "TruePlat" then
        truePlat = obj
    elseif obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "SpawnPlat" then
        obj.y = obj.y - TileSize
        spawnPlat = obj
    end
end

function data.MiscHandler(map) end

return data