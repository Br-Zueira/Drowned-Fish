local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local growList = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded()
    growList = {}
end

function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "moveColumn" then
            self:delete()
            local offset = TileSize*3
            for i = #props.propList, 1, -1 do
                local p = props.propList[i]
                if p.isFake then
                    p:delete()
                    props.Tile.new(p.x - offset, p.y)
                end
            end
        elseif self.id == "growPillar" then
            self:delete()
            for _, t in pairs(growList) do
                props.Tile.new(t.x, t.y)
            end
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    end
end

function data.MiscHandler(map)
    -- Iterates through a tile layer
    local layout = map.layers["FakeColumn"]
    for y = 1, layout.height do
        for x = 1, layout.width do
            local tile = layout.data[y][x]
            if tile then
                local pixelX = (x - 1) * TileSize
                local pixelY = (y - 1) * TileSize
                local t = props.Tile.new(pixelX, pixelY)
                t.isFake = true
            end
        end
    end

    local layout = map.layers["GrowPillar"]
    for y = 1, layout.height do
        for x = 1, layout.width do
            local tile = layout.data[y][x]
            if tile then
                local pixelX = (x - 1) * TileSize
                local pixelY = (y - 1) * TileSize
                table.insert(growList, {x=pixelX, y=pixelY})
            end
        end
    end

    local layout = map.layers["InvisiTiles"]
    for y = 1, layout.height do
        for x = 1, layout.width do
            local tile = layout.data[y][x]
            if tile then
                local pixelX = (x - 1) * TileSize
                local pixelY = (y - 1) * TileSize
                local t = props.Tile.new(pixelX, pixelY)
                t.renderTable = { isImg=nil }
            end
        end
    end
end

return data