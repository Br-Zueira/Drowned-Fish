local bump = require 'libs.bump'
local sti = require 'libs.sti'
local assets = require 'modules.assets'
local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Wrapper for world.lua
local world = {}

-- The current sector and level
---@type integer
local sector
---@type integer
local level

local levelsSchema = {
    [0] = {1},
    [1] = {1, 2, 3, 4, 5}
}

-- Updates level
---@param dt number The delta time for each rendered frame
---@param player Player The player instance
function world.update(dt, player)
    for _, obj in ipairs(props.propList) do
        if obj.update then obj:update(dt, player) end
    end
    local data = require('maps.sector' .. sector .. '.level' .. level .. '__data')
    if data.update then data.update(dt, player) end

    if assets.isPlayingAny('voicelines') then
        assets.songs.planetX:setVolume(0.5)
    else
        assets.songs.planetX:setVolume(1)
    end
end

-- Renders every prop in the map
function world.draw()
    -- Draws background before anything
    love.graphics.draw(assets.images.background, 0, 0)

    for _, instance in ipairs(props.propList) do
        -- If isImg is true, renders from asset
        -- If it's false, renders from solid color
        -- If it's nil, renders nothing (invisible)
        if not instance.isInvisible and instance.renderTable.isImg then
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
        elseif not instance.isInvisible and instance.renderTable.isImg == false then
            love.graphics.setColor(instance.renderTable.rgba)
            love.graphics.rectangle('fill', instance.x, instance.y, instance.sizeX, instance.sizeY)
        end
    end
end

-- Level renderer and reseter
---@param player Player The player instance
function world.reload(player)
    -- Resets player speed
    player.velX = 0
    player.velY = 0

    -- Updates voiceline manager
    voicelines.update()

    -- Resets player values that may have been changed
    player.gravity = player.gravityDefault
    player.jumpForce = player.jumpForceDefault
    player.velSpeed = player.velSpeedDefault

    -- Cleans the logic world
    props.propList = {}
    local map = sti('maps/sector' .. sector .. '/level' .. level .. '.lua')

    -- Recreates the physics world
    World = bump.newWorld(TileSize)
    World:add(player, player.x, player.y, player.width, player.height)

    -- Single level logic for every loading
    local data = require('maps.sector' .. sector .. '.level' .. level .. '__data')
    if data.whenReloaded then data.whenReloaded(player) end

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
        local p = obj.properties
        if obj.name == "Spawnpoint" then
            player.x = obj.x
            player.y = obj.y - TileSize
            World:update(player, obj.x, obj.y - TileSize, player.width, player.height)
        elseif obj.name == "Spike" then
            props.Spike.new(obj.x, obj.y)
        elseif obj.name == "Goal" then
            props.Goal.new(obj.x, obj.y)
        elseif obj.name == "Saw" then
            props.Saw.new(obj.x, obj.y)
        elseif obj.name == "MoverSaw" then
            props.MoverSaw.new(obj.x, obj.y, p.endX, p.endY, p.speed, p.isOneWay, p.isSinglePass)
        elseif obj.name == "InviSpike" then
            props.InviSpike.new(obj.x, obj.y, p.radius)
        elseif obj.name == "FakeGoal" then
            props.FakeGoal.new(obj.x, obj.y, p.newX, p.newY, p.radius)
        elseif obj.name == "Portal" then
            props.Portal.new(obj.x, obj.y, p.pair, p.isInvisible)
        else
            -- Level individual props
            if data.ObjHandler then data.ObjHandler(obj) end
        end
    end
    -- Handles everythin else, such as other layers
    if data.MiscHandler then data.MiscHandler(map) end
end

-- Custom logic to execute only while first loading the level
---@param newSector integer The new sector to be set in manager
---@param newLevel integer The new level to be set in manager
---@param player Player The player instance
function world.loadMap(newSector, newLevel, player)
    -- Resets module and level
    sector = newSector
    level = newLevel

    -- Resets voiceline manager
    voicelines.reset()

    -- Single level logic for first loading
    local data = require('maps.sector' .. sector .. '.level' .. level .. '__data')
    if data.whenLoaded then data.whenLoaded() end

    -- Resets death per level
    player.levelDeaths = 0

    -- Same logic as the one when level reloaded
    world.reload(player)
end

function world.nextLevel(player)
    if levelsSchema[sector][level + 1] then
        level = level + 1
    elseif levelsSchema[sector + 1] then
        sector = sector + 1
        level = 1
    else
        -- This would be an endgame thing, but we don't have it yet, so a placeholder here
        print("You won! (I could do it way faster, you loser)")
        local deathText = player.deaths == 0 and "(Pure luck, I can do it with my eyes closed)" or "(I'd have done it without ever dying)"
        print("Deaths:" .. " " .. player.deaths .. " " .. deathText)
        level = 1
        sector = 1
    end
    world.loadMap(sector, level, player)
end

return world