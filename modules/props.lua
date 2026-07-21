-- Wrapper to export everything
local props = {}

-- Stores all props in the world
props.propList = {}

-- Prop parent metatable
props.Prop = {}
props.Prop.__index = props.Prop

-- Creates a generic prop
function props.Prop.new(x, y, sizeX, sizeY, renderTable)
    -- Can be either {false, r, g, b, a}, {true, imgName} or {nil}
    renderTable = renderTable or { isImg=false, rgba={1, 1, 1, 1} }

    -- Creates instance
    local instance = { x=x, y=y, sizeX=sizeX, sizeY=sizeY, renderTable=renderTable }

    -- Binds instance to props metatable
    setmetatable(instance, props.Prop)

    -- Adds instance to physics world
    World:add(instance, x, y, sizeX, sizeY)

    -- Inserts instance into propList
    table.insert(props.propList, instance)
    return instance
end

function props.Prop:delete()
    -- Remove prop from physics
    if World:hasItem(self) then World:remove(self) end

    -- Remove prop form prop list
    for i, p in ipairs(props.propList) do
        if p == self then 
            table.remove(props.propList, i)
            return
        end
    end
end

-- Checks if player is closer from prop than given radius
function props.isPlayerInRadius(prop, player, radius)
    -- Find center point of player
    local px = player.x + (player.width / 2)
    local py = player.y + (player.height / 2)

    -- Find center point of prop
    local tx = prop.x + (prop.sizeX / 2)
    local ty = prop.y + (prop.sizeY / 2)

    -- Vector distance between centers
    local dx = px - tx
    local dy = py - ty

    -- Circular radius check using squared distance to reduce performance cost
    return (dx * dx + dy * dy) <= (radius * radius)
end

-- Inheriters
props.Tile = {}
props.Tile.__index = props.Tile

-- Binds child to parent table
setmetatable(props.Tile, props.Prop)

-- Creates a tile (simple square that serves as wall, floor or ceiling)
function props.Tile.new(x, y)
    -- Creates instance of parent metatable
    local instance = props.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='tile'})

    -- Binds instance into tile metatable
    setmetatable(instance, props.Tile)
    return instance
end

-- Spike
props.Spike = {}
props.Spike.__index = props.Spike
setmetatable(props.Spike, props.Prop)

function props.Spike.new(x, y)
    local instance = props.Prop.new(x, y - TileSize/2, TileSize, TileSize/2, { isImg=true, imgName='spike' })
    instance.isTrigger = true
    instance.type = 'Hazard'
    setmetatable(instance, props.Spike)
    return instance
end

-- Goal
props.Goal = {}
props.Goal.__index = props.Goal
setmetatable(props.Goal, props.Prop)

function props.Goal.new(x, y)
    y = y - TileSize
    local instance = props.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='goal' })
    instance.isTrigger = true
    instance.type = 'Goal'
    setmetatable(instance, props.Goal)
    return instance
end

-- Saw
props.Saw = {}
props.Saw.__index = props.Saw
setmetatable(props.Saw, props.Prop)

function props.Saw.new(x, y)
    y = y - TileSize
    local instance = props.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='saw' })
    instance.degrees = 0
    instance.isTrigger = true
    instance.type = 'Hazard'
    setmetatable(instance, props.Saw)
    return instance
end

function props.Saw:update(dt)
    self.degrees = (self.degrees + (720*dt)) % 360
end

-- Saw that deslocates
props.MoverSaw = {}
props.MoverSaw.__index = props.MoverSaw
setmetatable(props.MoverSaw, props.Saw)

function props.MoverSaw.new(x, y, endX, endY, speed)
    y = y - TileSize
    endY = endY - TileSize
    local instance = props.Saw.new(x, y)
    instance.x = x
    instance.y = y
    instance.startX = x
    instance.startY = y
    instance.endX = endX
    instance.endY = endY
    instance.speed = speed
    instance.isComingBack = false
    setmetatable(instance, props.MoverSaw)
end

function props.MoverSaw:update(dt)
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

-- Returns props to every module that imports this one
return props