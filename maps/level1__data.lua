local props = require 'modules.props'
local assets = require 'modules.assets'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded()
    voicelines.add('intro', 1)
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = levelTrigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    end
end

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "fakeTiles" then
            --[[ 
                Traditional for loop because 
                Removing requires reverse interation 
                In order to avoid errors
            ]]
            for i = #props.propList, 1, -1 do
                local prop = props.propList[i]
                if prop.isFake then prop:delete() end
            end
            self:delete()
        elseif self.id == "saw" then
            props.MoverSaw.new(self.x, VH, self.x, -999, 2000)
            self:delete()
        end
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

function data.update() end

return data