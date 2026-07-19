local assets = require 'modules.assets'

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
    local instance = { x=x, y=y, sizeX=sizeX, sizeY=sizeY, renderTable=renderTable}

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

-- Renders every prop in the map
function props.draw()
    for _, instance in ipairs(props.propList) do
        if (instance.renderTable.isImg) then
            -- Get the image asset
            local img = assets.images[instance.renderTable.imgName]

            -- Get the image's real pixel dimensions
            local imgW = img:getWidth()
            local imgH = img:getHeight()

            love.graphics.draw(
                img,
                instance.x + (instance.sizeX / 2), -- X Offset to match pivot point
                instance.y + (instance.sizeY / 2), -- Y Offset to match pivot point
                math.rad(instance.degrees) or 0, -- Love uses radians, but I want to store in degrees. This solves it
                (instance.sizeX / imgW), -- Changes X pivot point to instance center
                (instance.sizeY / imgH), -- Changes Y pivot point to instance center
                imgW/2,
                imgH/2,
                0, 0
            )
        else
            love.graphics.setColor(instance.renderTable.rgba)
            love.graphics.rectangle('fill', instance.x, instance.y, instance.sizeX, instance.sizeY)
        end
    end
end

-- Returns props to every module that imports this one
return props