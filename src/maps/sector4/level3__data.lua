local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local futureObjs = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(dt, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    if self.id == "changeGravity" then
        player.velY = math.max(0, math.min(800, player.velY - dt*2000))
        player.gravity = 0
        if self.alreadyFired then
            if player.velY == 0 then
                self:delete()
            end
            return
        end
        for _, prop in ipairs(props.propList) do
            if getmetatable(prop) == props.Goal then
                prop:delete()
                break
            end
        end
        for _, obj in ipairs(futureObjs.objects) do
            local n = obj.name
            local p = obj.properties
            if n == "Laser" then
                props.Laser.new(obj.x, obj.y, p.group, p.isDisabled, p.intermiTime, p.isFake)
            elseif n == "Goal" then
                props.Goal.new(obj.x, obj.y)
            end
        end
        self.alreadyFired = true
    elseif self.id == "invokeSaw" then
        self:delete()
        props.MoverSaw.new(self.x, VH+TileSize, self.x, -TileSize, 2000, true, true)
    elseif self.id == "invokeSaw2" then
        self:delete()
        props.MoverSaw.new(self.x, -TileSize, self.x, VH+TileSize, 2000, true, true)
    end
end

function data.whenReloaded() end
function data.update() end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    end
end

function data.MiscHandler(map)
    futureObjs = map.layers["FutureObjects"]
end

return data