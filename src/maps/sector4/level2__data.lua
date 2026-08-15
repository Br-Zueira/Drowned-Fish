local props = require 'modules.props'
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
function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "MovSpinningPlat" then
        local spinPoint = {}
        local sP = props.SpinningPlat.new(
            obj.x, obj.y,
            p.width, p.height,
            p.rotationSpeed, p.isCounterclockwise,
            function(self)
                self.rotationX = spinPoint.x
                self.rotationY = spinPoint.y
            end
        )
        spinPoint = props.Prop.new(sP[1].rotationX, sP[1].rotationY, TileSize, TileSize, { isImg=true, imgName='placeholder' })
        spinPoint.isTrigger = true
        props.Moveable.set(spinPoint, spinPoint.x, spinPoint.y, spinPoint.x, TileSize*6, p.speed, false, false)
    end
end
function data.MiscHandler(map) end

return data