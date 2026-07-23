local Saw = require 'modules.props.saw'

-- Saw that deslocates
---@class MoverSaw : Saw
---@field x number X coordinate of mover saw
---@field y number Y coordinate of mover saw
---@field startX number Starting X coordinate of mover saw
---@field startY number Starting Y coordinate of mover saw
---@field endX number Ending X coordinate of mover saw
---@field endY number Ending X coordinate of mover saw
---@field speed number Speed of mover saw
---@field isOneWay boolean If true, the saw moves in a single direction
---@field isSinglePass boolean If true, the saw will be deleted after reaching the end point
local MoverSaw = {}
MoverSaw.__index = MoverSaw
setmetatable(MoverSaw, Saw)

-- Creates a new MoverSaw
---@param x number Starting X coordinate of mover saw
---@param y number Starting Y coordinate of mover saw
---@param endX number Ending X coordinate of mover saw
---@param endY number Ending X coordinate of mover saw
---@param speed number Speed of mover saw
---@param isOneWay? boolean If true, the saw moves in a single direction
---@param isSinglePass? boolean If true, the saw will be deleted after reaching the end point
---@return MoverSaw
function MoverSaw.new(x, y, endX, endY, speed, isOneWay, isSinglePass)
    y = y - TileSize
    endY = endY - TileSize
    local instance = Saw.new(x, y)
    ---@cast instance MoverSaw
    instance.x = x
    instance.y = y
    instance.startX = x
    instance.startY = y
    instance.endX = endX
    instance.endY = endY
    instance.speed = speed
    instance.isComingBack = false
    instance.isOneWay = isOneWay or false
    instance.isSinglePass = isSinglePass or false
    setmetatable(instance, MoverSaw)
    return instance
end

-- Filter that ignores every colision with saw
local colFilter = function(o)
    if o.type == 'Player' then
        return 'slide'
    end
    return 'cross'
end

-- Updates the mover saw, moving and rotating it
---@param dt number Delta time for each rendered frame
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
        self.x, self.y = World:move(self, self.x + dirX*speed, self.y + dirY*speed, colFilter)
    else
        -- If single pass, deletes itself and aborts execution of the rest of the script
        if self.isSinglePass then self:delete() return end

        if self.isOneWay then
            -- Goes back to starting point
            World:update(self, self.startX, self.startY, self.sizeX, self.sizeY)
            self.x, self.y = self.startX, self.startY
        else
            -- Avoids overshooting target
            self.x, self.y = World:move(self, pointX, pointY, colFilter)

            -- If in target, inverses boolean
            self.isComingBack = not self.isComingBack
        end
    end
end

return MoverSaw