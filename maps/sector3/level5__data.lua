local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Custom, single level data
local data = {}

local points = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

function data.whenReloaded()
    points = {}
end

function data.update() end

function data.ObjHandler(obj)
    if obj.name == "LaserPoint" then
        local i = { x=obj.x, y=obj.y - TileSize, point=obj.properties.point }
        table.insert(points, i)
    end
end

function data.MiscHandler(map)
    for i, p in ipairs(points) do
        if p.point ~= 1 and p.point ~= 3 then return end
        local l = props.Laser.new(p.x, p.y + TileSize)
        l.currentPoint = p.point
        local endX, endY = points[i+2].x, points[i+2].y
        props.Moveable.set(
            l, l.x, l.y,
            endX, endY,
            200, false, false,
            function(self, dt, player)
                props.Laser.update(self, dt, player)
                if not self.isComingBack then return end
                self.isComingBack = false
                local nextP = points[l.currentPoint + 1]
                if nextP then
                    self.endX, self.endY = nextP.x, nextP.y
                else
                    self.endX, self.endY = points[1].x, points[i].y
                end
            end
        )
    end
end

return data