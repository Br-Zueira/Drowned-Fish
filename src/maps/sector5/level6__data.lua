local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded()
    voicelines.add('end', 1)
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('death_highscore', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded(player) end
function data.update(dt, player) end
function data.ObjHandler(obj) end
function data.MiscHandler(map) end

return data