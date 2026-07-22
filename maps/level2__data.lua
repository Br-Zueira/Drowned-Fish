local props = require 'modules.props'

-- Custom, single level data
local data = {}

function data.whenLoaded() end
function data.whenReloaded() end
function data.update() end

-- A fake goal that also deletes fake tiles
local FakeGoalDeleter = {}
FakeGoalDeleter.__index = FakeGoalDeleter
setmetatable(FakeGoalDeleter, props.FakeGoal)

-- Spikes that only appear after fake goal moves
local afterSpikes = {}

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "FakeGoalDeleter" then
        local i = props.FakeGoal.new(obj.x, obj.y, p.newX, p.newY, p.radius)
        setmetatable(i, FakeGoalDeleter)
    elseif obj.name == "AfterSpike" then
        table.insert(afterSpikes, obj)
    end
end

function FakeGoalDeleter:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        for i = #props.propList, 1, -1 do
            local prop = props.propList[i]
            if prop.isFake then prop:delete() end
        end
        for _, s in ipairs(afterSpikes) do
            local p = s.properties
            if p.ChosenOne then
                props.InviSpike.new(s.x, s.y, p.range, 180)
            else
                props.Spike.new(s.x, s.y)
            end
        end
        props.Goal.new(self.newX, self.newY)
        player.gravity = player.gravity/3 -- 1/3 of original value
        self:delete()
    end
end

function data.MiscHandler(map)
    -- Iterates through a fake tile layer
    local layout = map.layers["FakeTiles"]
    for y = 1, layout.height do
        for x = 1, layout.width do
            local tile = layout.data[y][x]
            if tile then
                local pixelX = (x - 1) * TileSize
                local pixelY = (y - 1) * TileSize
                local tile = props.Tile.new(pixelX, pixelY)
                tile.isFake = true
            end
        end
    end
end

return data