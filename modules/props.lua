-- Wrapper to export everything
local props = {}

-- Stores all props in the world
props.propList = {}

-- Prop parent metatable
props.Prop = {}
props.Prop.__index = props.Prop

-- Creates a generic prop
function props.Prop.new(x, y, sizeX, sizeY, renderTable)
    -- Can be either {false, r, g, b, a} or {true, imgName}
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

-- Props that kill player if touched, such as spikes or saws
props.Killable = {}
props.Killable.__index = props.Killable
setmetatable(props.Killable, props.Prop)

-- Lethal props
function props.Killable.new(x, y, sizeX, sizeY, renderTable)
    local instance = props.Prop.new(x, y, sizeX, sizeY, renderTable)
    setmetatable(instance, props.Killable)
    instance.isTrigger = true
    return instance
end

function props.Killable:update(dt, player)
    local items, len = World:queryRect(self.x, self.y, self.sizeX, self.sizeY)
    for i = 1, len do
        if items[i] == player then
            player:death()
            break
        end
    end
end

-- Spike
props.Spike = {}
props.Spike.__index = props.Spike
setmetatable(props.Spike, props.Killable)

function props.Spike.new(x, y)
    local instance = props.Killable.new(x, y - TileSize/2, TileSize, TileSize/2, { isImg=true, imgName='spike' })
    setmetatable(instance, props.Spike)
    return instance
end

-- Returns props to every module that imports this one
return props