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

local futureSpinningPlatsList = {}
local willChangeDir = {}

function data.whenReloaded()
    futureSpinningPlatsList = {}
    willChangeDir = {}
end

function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    if self.id == "revealPlatforms" then
        self:delete()
        for i = #props.propList, 1, -1 do
            local prop = props.propList[i]
            if prop.isFake then
                prop:delete()
            end
        end
        for _, fSP in ipairs(futureSpinningPlatsList) do
            local p = fSP.properties
            local spinningPlat = props.SpinningPlat.new(fSP.x, fSP.y, p.width, p.height, p.speed, p.isCounterclockwise)
            if p.willChangeDir then
                willChangeDir = spinningPlat
                willChangeDir.futureSpeed = p.futureSpeed or p.speed
            end
        end
    elseif self.id == "invertPlatform" then
        self:delete()
        if not willChangeDir then return end
        for _, tile in ipairs(willChangeDir) do
            tile.isCounterclockwise = not tile.isCounterclockwise
            tile.rotationSpeed = willChangeDir.futureSpeed
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "FutureSpinningPlat" then
        table.insert(futureSpinningPlatsList, obj)
    elseif obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    end
end

function data.MiscHandler(map)
    local fakeStaticPlats = map.layers["FakeStaticPlats"]
    for y = 1, fakeStaticPlats.height do
        for x = 1, fakeStaticPlats.width do
            local tile = fakeStaticPlats.data[y][x]
            if tile then
                local pixelX = (x - 1) * TileSize
                local pixelY = (y - 1) * TileSize
                local t = props.Tile.new(pixelX, pixelY)
                t.isFake = true
            end
        end
    end
end

return data