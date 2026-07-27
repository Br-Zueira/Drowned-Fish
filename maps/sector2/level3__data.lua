local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded() end
function data.whenReloaded() end
function data.update() end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        if self.id == "movTile" then
            for _, prop in ipairs(props.propList) do
                if prop.type == "customTile" and prop.id == "Mov" then
                    self:delete()
                    local offset = TileSize*4
                    prop:delete()
                    props.Tile.new(prop.x, prop.y-offset)
                    break
                end
            end
        elseif self.id == "fakeTile" then
            for _, prop in ipairs(props.propList) do
                if prop.type == "customTile" and prop.id == "Fake" then
                    self.delete()
                    prop:delete()
                    break
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
    elseif obj.name == "Tile" then
        local t = props.Tile.new(obj.x, obj.y - TileSize)
        t.id = p.id
        t.type = "customTile"
    end
end

function data.MiscHandler(map) end

return data