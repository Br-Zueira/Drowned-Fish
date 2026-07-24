local props = require 'modules.props'
local assets = require 'modules.assets'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local sawList = {}
local canSpawnSaws = false
local secs = 5
local timer = secs
local step = 1

function data.whenLoaded() end
function data.whenReloaded()
    canSpawnSaws = false
    sawList = {}
end

function data.update(dt)
    if canSpawnSaws then
        timer = timer - dt
        if timer <= 0 then
            timer = secs
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == 'MovPlat' then
        local i = props.MoverSaw.new(obj.x, obj.y, 480, 320, p.speed)
        i.renderTable.imgName = 'tile'
        i.type = 'Solid'
        i.isCross = false
        i.didReachPoint = false
        function i:update(dt, player)
            props.MoverSaw.update(self, dt, player)
            self.degrees = 0
            if self.isComingBack then
                self.isComingBack = false
                self.isSinglePass = true
                self.endY = VH
            end
        end
    elseif obj.name == 'SpawnSaw' then 
        table.insert(sawList, obj)
    end
end

function data.MiscHandler(map) end

return data