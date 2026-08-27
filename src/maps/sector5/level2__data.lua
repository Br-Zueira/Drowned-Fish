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
    player.controls = controls

    if love.keyboard.isDown(player.controls.kill) then
        player:death()
    end
end

function data.ObjHandler(obj) end
function data.MiscHandler(map) end

return data