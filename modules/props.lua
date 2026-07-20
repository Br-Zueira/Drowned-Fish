local sti = require 'libs.sti'
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

props.Spike = {}
props.Spike.__index = props.Spike
setmetatable(props.Spike, props.Killable)

function props.Spike.new(x, y)
    local instance = props.Killable.new(x, y - TileSize/2, TileSize, TileSize/2, { isImg=true, imgName='spike' })
    setmetatable(instance, props.Spike)
    return instance
end

function props.update(dt, player)
    for _, obj in ipairs(props.propList) do
        if obj.update then obj:update(dt, player) end
    end
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

            -- Love uses radians, but I want to store in degrees. This solves it
            local radians = 0
            if instance.degrees then
                radians = math.rad(instance.degrees)
            end

            love.graphics.draw(
                img,
                instance.x + (instance.sizeX / 2), -- X Offset to match pivot point
                instance.y + (instance.sizeY / 2), -- Y Offset to match pivot point
                radians,
                (instance.sizeX / imgW), -- Changes X pivot point to instance center
                (instance.sizeY / imgH), -- Changes Y pivot point to instance center
                imgW/2,
                imgH/2
            )
        else
            love.graphics.setColor(instance.renderTable.rgba)
            love.graphics.rectangle('fill', instance.x, instance.y, instance.sizeX, instance.sizeY)
        end
    end
end

-- Level renderer and reseter
function props.reload(path, player)
    props.propList = {}
    local map = sti(path)

    -- Iterates through a tile layer
    local layout = map.layers["Layout"]
    for y = 1, layout.height do
        for x = 1, layout.width do
            local tile = layout.data[y][x]
            if tile then
                local pixelX = (x - 1) * TileSize
                local pixelY = (y - 1) * TileSize
                props.Tile.new(pixelX, pixelY)
            end
        end
    end

    -- Iterates through an object layer
    local objectLayer = map.layers["Objects"]
    for _, obj in ipairs(objectLayer.objects) do
        if obj.name == "Spawnpoint" then
            player.spawnX = obj.x
            player.spawnY = obj.y
            player.x = obj.x
            player.y = obj.y
            World:update(player, obj.x, obj.y, player.width, player.height)
        end
        if obj.name == "Spike" then
            props.Spike.new(obj.x, obj.y)
        end
    end
end

-- Custom logic to execute only while first loading the level
function props.loadMap(path, player)
    player.levelDeaths = 0
    props.reload(path, player)
end

-- Returns props to every module that imports this one
return props