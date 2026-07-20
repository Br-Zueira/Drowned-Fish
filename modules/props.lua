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

-- Returns props to every module that imports this one
return props