local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local controls = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)

    local keys = {}
    for i = 97, 122 do
        local char = string.char(i)
        if char ~= 'p' then
            table.insert(keys, char)
        end
    end
    controls.left = table.remove(keys, math.random(1, #keys))
    controls.right = table.remove(keys, math.random(1, #keys))
    controls.jump = table.remove(keys, math.random(1, #keys))
    controls.kill = table.remove(keys, math.random(1, #keys))
end

function data.whenReloaded() end

function data.update(_, player)
    player.gravity = -player.gravityDefault*4
    player.jumpForce = player.jumpForceDefault*3
    player.controls = love.keyboard.isDown("space") and {left='a', right='d', jump='w', kill='o'} or controls
    player.killHeight = VH+TileSize*10

    if love.keyboard.isDown(player.controls.kill) then
        player:death()
    end
end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    self:delete()
    if self.id == "movLasers" then
        for _, p in ipairs(props.propList) do
            if getmetatable(p) == props.Laser then
                if p.y < self.y then
                    props.Moveable.set(p, p.x, p.y, p.x, TileSize*5, 125, false, false, props.Laser.update)
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
    end
end

function data.MiscHandler(map) end

return data