local Saw = require 'modules.props.saw'

-- Saw that deslocates
MoverSaw = {}
MoverSaw.__index = MoverSaw
setmetatable(MoverSaw, Saw)

function MoverSaw.new(x, y, endX, endY, speed)
    y = y - TileSize
    endY = endY - TileSize
    local instance = Saw.new(x, y)
    instance.x = x
    instance.y = y
    instance.startX = x
    instance.startY = y
    instance.endX = endX
    instance.endY = endY
    instance.speed = speed
    instance.isComingBack = false
    setmetatable(instance, MoverSaw)
end

function MoverSaw:update(dt)
    -- Usual saw rotation
    self.degrees = (self.degrees + (720*dt)) % 360

    -- Sees the movement direction
    local pointX, pointY
    if self.isComingBack then
        pointX = self.startX
        pointY = self.startY
    else
        pointX = self.endX
        pointY = self.endY
    end

    -- Distance X and distance Y
    local dx = pointX - self.x
    local dy = pointY - self.y

    -- Euclidian distance
    local distance = math.sqrt(dx * dx + dy * dy)

    -- Speed for this frame
    local speed = self.speed * dt

    -- If not on target
    if distance > speed then
        -- Normalize vector so length is 1
        local dirX = dx/distance
        local dirY = dy/distance
        self.x, self.y = World:move(self, self.x + dirX*speed, self.y + dirY*speed)
    else
        -- Avoids overshooting target
        self.x, self.y = World:move(self, pointX, pointY)

        -- If in target, inverses boolean
        self.isComingBack = not self.isComingBack
    end
end

return MoverSaw