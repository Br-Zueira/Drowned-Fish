local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded()
    voicelines.add('portals', 1)
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

local portalHid

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        for i = #props.propList, 1, -1 do
            local prop = props.propList[i]
            if prop.isFake then prop:delete() end
        end
        props.Portal.new(portalHid.x, portalHid.y, portalHid.properties.pair)
        self:delete()
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "PortalHid" then
        portalHid = obj
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