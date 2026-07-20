local bump = require 'libs.bump'
local sti = require 'libs.sti'
local assets = require 'modules.assets'
local props = require 'modules.props'

local world = {}

local level

-- Updates level
function world.update(dt, player)
    for _, obj in ipairs(props.propList) do
        if obj.update then obj:update(dt, player) end
    end
end

-- Renders every prop in the map
function world.draw()
    for _, instance in ipairs(props.propList) do
        -- If isImg is true, renders from asset
        -- If it's false, renders from solid color
        -- If it's nil, renders nothing (invisible)
        if instance.renderTable.isImg then
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
        elseif instance.renderTable.isImg == false then
            love.graphics.setColor(instance.renderTable.rgba)
            love.graphics.rectangle('fill', instance.x, instance.y, instance.sizeX, instance.sizeY)
        end
    end
end

-- Level renderer and reseter
function world.reload(player)
    -- Cleans the logic world
    props.propList = {}
    local map = sti('maps/level' .. level .. '.lua')

    -- Recreates the physics world
    World = bump.newWorld(TileSize)
    World:add(player, player.x, player.y, player.width, player.height)

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
        -- Basic/universal props
        if obj.name == "Spawnpoint" then
            player.x = obj.x
            player.y = obj.y - TileSize
            World:update(player, obj.x, obj.y - TileSize, player.width, player.height)
        elseif obj.name == "Spike" then
            props.Spike.new(obj.x, obj.y)
        elseif obj.name == "Goal" then
            props.Goal.new(obj.x, obj.y)
        else
            -- Level individual props
            local data = require('maps.level' .. level .. '__data')
            data.handler(obj)
        end
    end
end

-- Custom logic to execute only while first loading the level
function world.loadMap(newLevel, player)
    level = newLevel
    player.levelDeaths = 0
    world.reload(player)
end

function world.nextLevel(player)
    level = level + 1
    world.loadMap(level, player)
end

return world