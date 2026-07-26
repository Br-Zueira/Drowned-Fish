local props = require 'modules.props.prop'

-- Prop that deslocates
---@class Moveable : Prop
---@field x number X coordinate
---@field y number Y coordinate
---@field startX number Starting X coordinate
---@field startY number Starting Y coordinate
---@field endX number Ending X coordinate
---@field endY number Ending X coordinate
---@field speed number Speed
---@field isOneWay boolean If true, moveable moves in a single direction
---@field isSinglePass boolean If true, moveable will be deleted after reaching the end point
---@field isComingBack boolean Defines the direction the moveable is going to
---@field customUpdate? function Optional function that will be executed along with traditional moveable update
local Moveable = {}
Moveable.__index = Moveable
setmetatable(Moveable, props.Prop)

-- Creates a new MoverSaw
---@param instance Prop The prop to be set as a moveable
---@param x number Starting X coordinate of mover saw
---@param y number Starting Y coordinate of mover saw
---@param endX number Ending X coordinate of mover saw
---@param endY number Ending X coordinate of mover saw
---@param speed number Speed of mover saw
---@param isOneWay? boolean If true, the saw moves in a single direction
---@param isSinglePass? boolean If true, the saw will be deleted after reaching the end point
---@param customUpdate? function Optional function that will be executed along with traditional moveable update
---@return Moveable
function Moveable.set(instance, x, y, endX, endY, speed, isOneWay, isSinglePass, customUpdate)
    ---@cast instance Moveable
    instance.y = instance.y - TileSize
    instance.startX = x
    instance.startY = y - TileSize
    instance.endX = endX
    instance.endY = endY - TileSize
    instance.speed = speed
    instance.isComingBack = false
    instance.isOneWay = isOneWay or false
    instance.isSinglePass = isSinglePass or false
    instance.customUpdate = customUpdate or function() end
    setmetatable(instance, Moveable)
    return instance
end

-- Filter that ignores every colision with moveable
local colFilter = function(_, o)
    if o.type == 'Player' then
        return 'cross'
    end
    return nil
end

-- Updates the mover saw, moving and rotating it
---@param dt number Delta time for each rendered frame
function Moveable:update(dt, player)
    self.customUpdate(self, dt, player)

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

    -- Normalize vector so length is 1
    local speedDT = self.speed*dt

    -- If not on target
    if distance > speedDT then
        local dirX = dx/distance
        local dirY = dy/distance
        local cols, len
        self.x, self.y, cols, len = World:move(self, self.x + dirX*speedDT, self.y + dirY*speedDT, colFilter)
        self.velX = dirX*self.speed
        self.velY = dirY*self.speed
        for i = 1, len do
            local col = cols[i]
            local o = col.other
            if col.normal.y == 1 and o.type == "Player" then
                local targetX = o.x + (self.velX*dt)
                local targetY = o.y - (self.velY*dt)
                o.x, o.y = World:move(o, targetX, targetY)
            end
        end
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
        self.velX = 0
        self.velY = 0
    end
end

return Moveable