local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded() end

function data.whenReloaded()
    local fake = props.MoverSaw.new(672, 672, 672, 0, 100)
    fake.type = 'Solid'
    fake.isCross = false
end

function data.update() end

function data.ObjHandler(obj) end

function data.MiscHandler(map) end

return data