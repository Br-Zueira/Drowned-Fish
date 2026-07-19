-- Wrapper to export everything
local props = {}

-- Stores all props in the world
props.propList = {}

-- Prop parent metatable
props.Prop = {}
props.Prop.__index = props.Prop

-- Creates a generic prop
function props.Prop.new(x, y, sizeX, sizeY, color)
    -- Creates instance
    local instance = { x=x, y=y, sizeX=sizeX, sizeY=sizeY, color=color or {1, 1, 1, 1}}

    -- Binds instance to props metatable
    setmetatable(instance, props.Prop)

    -- Adds instance to physics world
    World:add(instance, x, y, sizeX, sizeY)

    -- Inserts instance into propList
    table.insert(props.propList, instance)
    return instance
end

-- Inheriters
props.Tile = {}
props.Tile.__index = props.Tile

-- Binds child to parent table
setmetatable(props.Tile, props.Prop)

-- Creates a tile (simple square that serves as wall, floor or ceiling)
function props.Tile.new(x, y)
    -- Creates instance of parent metatable
    local instance = props.Prop.new(x, y, TileSize, TileSize, {0, 1, 0, 0.9})

    -- Binds instance into tile metatable
    setmetatable(instance, props.Tile)
    return instance
end

-- Renders every prop in the map
function props.draw()
    for i, instance in ipairs(props.propList) do
        love.graphics.setColor(instance.color)
        love.graphics.rectangle('fill', instance.x, instance.y, instance.sizeX, instance.sizeY)
    end
end

-- Returns props to every module that imports this one
return props