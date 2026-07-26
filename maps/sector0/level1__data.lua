local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

function data.whenLoaded() end

function data.whenReloaded()
    local x1 = 200
    local y1 = 464
    local x2 = 672
    local y2 = 224
    local fake = props.MoverSaw.new(x1, y1, x2, y2, 100)
    fake.type = 'Solid'
    fake.isCross = false
end

function data.update() end

function data.ObjHandler(obj) end

function data.MiscHandler(map) end

return data