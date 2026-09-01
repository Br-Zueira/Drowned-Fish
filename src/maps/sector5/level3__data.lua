local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Cursor idea: Cursor that brings saw while player is at the gap, then a portal reveals itself right at the last second

-- Custom, single level data
local data = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded(player) end
function data.update() end
function data.ObjHandler(obj) end
function data.MiscHandler(map) end

return data