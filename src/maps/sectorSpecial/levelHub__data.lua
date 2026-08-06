local props = require 'modules.props'
local world = require 'modules.world'
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

local sectorGate = {}
sectorGate.__index = sectorGate
setmetatable(sectorGate, props.Prop)

function sectorGate.new(x, y, sec)
    y = y - TileSize
    local renderTable = { isImg=true, imgName="placeholder" }
    local instance = props.Prop.new(x, y, TileSize, TileSize, renderTable)
    instance.isCross = true
    instance.type = "SectorGate"
    instance.sector = sec
    setmetatable(instance, sectorGate)
    return instance
end

function sectorGate:update(_, player)
    if not World:hasItem(self) then return end
    local _, _, cols, len = World:check(self, self.x, self.y)
    for i = 1, len do
        local col = cols[i]
        if col.other == player then
            player.deaths = 0
            world.loadMap(self.sector, 1, player)
            return
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Sector" then
        if not world.save[p.sector] or not world.save[p.sector].unlocked then return end
        sectorGate.new(obj.x, obj.y, p.sector)
    end
end

function data.MiscHandler(map) end

return data