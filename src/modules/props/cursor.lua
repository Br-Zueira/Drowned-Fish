local prop = require 'modules.props.prop'

-- Inheriters
---@class Cursor : Prop
---@field x number X coordinates of cursor
---@field y number Y coordinates of cursor
---@field isTrigger boolean Controls whether the cursor is a solid prop (false by default)
---@field layer number Rendering layer of cursor
local Cursor = {}
Cursor.__index = Cursor

-- Binds child to parent table
setmetatable(Cursor, prop.Prop)

-- Creates a cursor (simple square that serves as wall, floor or ceiling)
---@param x number X coordinates of cursor
---@param y number Y coordinates of cursor
---@param isSolid? boolean Controls whether the cursor is a solid prop (false by default)
---@return Cursor
function Cursor.new(x, y, isSolid)
    -- Adjusts Y coordinates because of Tiled object layer quirks
    y = y - TileSize

    -- Creates instance of parent metatable
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='cursor' })

    ---@cast instance Cursor
    -- Binds instance into cursor metatable
    setmetatable(instance, Cursor)

    -- Turns cursor into non solid by default
    instance.isTrigger = isSolid ~= true

    -- Rendering order
    instance.layer = 999

    return instance
end

-- Filter that ignores every colision with cursor
local colFilter = function(_, o)
    if o.type == 'Player' then
        return 'cross'
    end
    return nil
end

function Cursor:update(dt, player)
    -- Avoids crashes
    if not World:hasItem(self) then return end
    if not self.goal then return end

    -- Allows dynamic goals
    self.goalX = self.goal.x
    self.goalY = self.goal.y

    -- Avoids bugs
    if not self.goalX or not self.goalY then return end

    -- Sees the movement direction
    local pointX, pointY
    pointX = self.goalX
    pointY = self.goalY

    -- Distance X and distance Y
    local dx = pointX - self.x
    local dy = pointY - self.y

    -- Euclidian distance
    local distance = math.sqrt(dx * dx + dy * dy)

    -- Calculates speed for current frame
    local speed = self.speed

    -- Calculates dynamic speed if needed
    if self.isFixedTime then
        -- Avoids division by 0 errors
        if self.time == 0 then return end
        speed = distance/self.time
    end

    -- Normalize vector so length is 1
    local speedDT = speed*dt

    -- If not on target
    if distance > speedDT then
        local dirX = dx/distance
        local dirY = dy/distance
        local cols, len
        self.x, self.y, cols, len = World:move(self, self.x + dirX*speedDT, self.y + dirY*speedDT, colFilter)
        self.velX = dirX * speed
        self.velY = dirY * speed
        if self.isFixedTime then self.time = math.max(0, self.time - dt) end

        -- Both avoids crashed and improper checks
        if self.isTrigger or not World:hasItem(player) then return end
        for i = 1, len do
            local col = cols[i]
            local o = col.other
            -- Corrects user position
            if col.normal.y == 1 and o.type == "Player" then
                if not o.velY or o.velY >= 0 then
                    local targetY = o.y - (self.velY*dt)
                    o.x, o.y = World:move(o, o.x, targetY, player.worldFilter)
                end
            end
        end
    else
        -- Avoids overshooting target
        self.x, self.y = World:move(self, pointX, pointY, colFilter)

        -- Zeroes velocity to avoid errors
        self.velX = 0
        self.velY = 0

        -- Zeroes other variables to avoid errors
        self.goal = nil
        self.time = 0
        self.speed = 0
    end
end

-- Sets the cursor to go to a specific place in a specific amount of seconds
---@param goal table Goal coordinates in format { x=x. y=y }
---@param velocity table Velocity in format { isFixedTime=false/true, time=seconds/speed=speed }
function Cursor:goto(goal, velocity)
    self.goal = goal

    self.isFixedTime = velocity.isFixedTime
    if self.isFixedTime then
        self.time = velocity.time
    else
        self.speed = velocity.speed
    end
end

return Cursor