local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local points = {}
local isInverted = false
local spawnPlat, spawnPlatEnd

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded()
    points = {}
    isInverted = false
end

function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    if self.id == "invertLaser" then
        self:delete()
        isInverted = true
    elseif self.id == "movTile" then
        self:delete()
        for _, prop in ipairs(props.propList) do
            if prop.isMov then
                prop:delete()
                return
            end
        end
    elseif self.id == "spawnPlat" then
        self:delete()
        local plat = props.Tile.new(spawnPlat.x, spawnPlat.y - TileSize)
        props.Moveable.set(
            plat, plat.x, plat.y,
            spawnPlatEnd.x, spawnPlatEnd.y,
            spawnPlat.properties.speed, false, false,
            function(self)
                if self.isComingBack then
                    setmetatable(plat, props.Tile)
                end
            end
        )
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "LaserPoint" then
        local i = { x=obj.x, y=obj.y - TileSize, point=p.point }
        table.insert(points, i)
    elseif obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "MovTile" then
        local t = props.Tile.new(obj.x, obj.y - TileSize)
        t.isMov = true
    elseif obj.name == "SpawnPlat" then
        spawnPlat = obj
    elseif obj.name == "SpawnPlatEnd" then
        spawnPlatEnd = obj
    end
end

local function searchPoint(index)
    for _, p in ipairs(points) do
        if p.point == index then return p end
    end
end

local function updateLaser(self, dt, player)
    props.Laser.update(self, dt, player) -- Basically 'togglable' options for laser emmitter
    if not self.isComingBack then return end

    self.isComingBack = false
    self.startX, self.startY = self.endX, self.endY

    local nextIndex
    if isInverted then
        nextIndex = self.currentPoint-1
    else
        nextIndex = self.currentPoint+1
    end

    local nextP = searchPoint(nextIndex)
    if nextP then
        self.endX, self.endY = nextP.x, nextP.y
        self.currentPoint = nextIndex
    else
        local reset = isInverted and #points or 1
        self.endX, self.endY = searchPoint(reset).x, searchPoint(reset).y
        self.currentPoint = reset
    end
end

function data.MiscHandler(map)
    for _, p in ipairs(points) do
        if p.point == 1 or p.point == 3 then
            local l = props.Laser.new(p.x, p.y + TileSize*2)
            l.currentPoint = p.point
            local endX, endY = searchPoint(p.point+1).x, searchPoint(p.point+1).y + TileSize
            props.Moveable.set(
                l, l.x, l.y,
                endX, endY,
                200, false, false,
                updateLaser
            )
        end
    end
end

return data