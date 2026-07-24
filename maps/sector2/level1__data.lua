local props = require 'modules.props'
local assets = require 'modules.assets'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local sawList = {}
local canSpawnSaws = false
local secs = 2
local timer = secs
local step = 1

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded()
    canSpawnSaws = false
    sawList = {}
    timer = secs
    step = 1
end

function data.update(dt)
    if canSpawnSaws then
        timer = timer - dt
        if timer <= 0 then
            timer = secs
            for i = #sawList, 1, -1 do
                local p = sawList[i]
                if p.properties.order == step then
                    table.remove(sawList, i)
                    local i = props.MoverSaw.new(p.x, p.y, VW, p.y, p.properties.speed, true, true)
                    if p.properties.isFake then
                        i.isCross = false
                        i.type = 'Solid'
                    end
                end
            end
            step = step + 1
        end
    end
end

local function customUpdate(self)
    if self.isComingBack then
        self.isComingBack = false
        self.isSinglePass = true
        self.endY = VH
        canSpawnSaws = true
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == 'MovPlat' then
        local i = props.Tile.new(obj.x, obj.y)
        props.Moveable.set(i, i.x, i.y, 480, 320, p.speed, false, false, customUpdate)
    elseif obj.name == 'SpawnSaw' then
        table.insert(sawList, obj)
    end
end

function data.MiscHandler(map) end

return data