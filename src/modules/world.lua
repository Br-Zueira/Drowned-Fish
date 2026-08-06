local bump = require 'libs.bump'
local sti = require 'libs.sti'
local assets = require 'modules.assets'
local props = require 'modules.props'
local voicelines = require 'modules.voicelines'
local save = require 'modules.save'

-- Wrapper for world.lua
local world = {}

-- The current sector and level
---@type integer | string
world.sector = 1
---@type integer | string
world.level = 1

world.levelsSchema = {
    [0] = {1},
    [1] = {1, 2, 3, 4, 5},
    [2] = {1, 2, 3, 4, 5},
    [3] = {1, 2, 3, 4, 5},
    ["Special"] = {"Hub"}
}

local bgSchema = {
    [0] = 'deep',
    [1] = 'cold',
    [2] = 'purpleish',
    [3] = 'redish',
    ["Special"] = 'lunarground'
}

world.save = save.loadJson("save")
if not world.save then
    world.save = { [1] = { unlocked=true } }
end

-- Updates level
---@param dt number The delta time for each rendered frame
---@param player Player The player instance
function world.update(dt, player)
    for _, obj in ipairs(props.propList) do
        if obj.update then obj:update(dt, player) end
    end
    local data = require('maps.sector' .. world.sector .. '.level' .. world.level .. '__data')
    if data.update then data.update(dt, player) end

    local songsVolume = assets.volume.songs.muted and 0 or assets.volume.songs.volume
    if assets.isPlayingAny('voicelines') and not assets.volume.voicelines.muted and assets.volume.voicelines.volume ~= 0 then
        assets.songs.planetX:setVolume(songsVolume/2)
    else
        assets.songs.planetX:setVolume(songsVolume)
    end
end

-- Renders every prop in the map
function world.draw()
    -- Draws background before anything
    local bg = assets.backgrounds[bgSchema[world.sector]]
    love.graphics.draw(bg, 0, 0, 0, VW/bg:getWidth(), VH/bg:getHeight())

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

        if instance.type == "SectorGate" then
            local f = assets.fonts.VT323
            love.graphics.setFont(f)
            local display = "Sector " .. instance.sector
            local dX = math.floor(instance.x + TileSize/2 - f:getWidth(display)/2)
            local dY = instance.y - TileSize*2
            love.graphics.print(display, dX, dY)

            -- Shows sector deaths
            local deaths = world.save[instance.sector].deaths
            if deaths then
                display = "Least Deaths: " .. deaths
                dX = math.floor(instance.x + TileSize/2 - f:getWidth(display)/2)
                dY = dY + f:getHeight()
                love.graphics.print(display, dX, dY)
            end
        end
        if instance.draw then instance:draw() end
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
    local map = sti('maps/sector' .. world.sector .. '/level' .. world.level .. '.lua')

    -- Recreates the physics world
    World = bump.newWorld(TileSize)
    World:add(player, player.x, player.y, player.width, player.height)

    -- Single level logic for every loading
    local data = require('maps.sector' .. world.sector .. '.level' .. world.level .. '__data')
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
        elseif obj.name == "Spring" then
            props.Spring.new(obj.x, obj.y)
        elseif obj.name == "Booster" then
            props.Booster.new(obj.x, obj.y, p.speed, obj.rotation)
        elseif obj.name == "Laser" then
            props.Laser.new(obj.x, obj.y, p.group, p.isDisabled, p.intermiTime, p.isFake)
        else
            -- Level individual props
            if data.ObjHandler then data.ObjHandler(obj) end
        end
    end
    -- Handles everythin else, such as other layers
    if data.MiscHandler then data.MiscHandler(map) end
end

-- Custom logic to execute only while first loading the level
---@param newSector integer | string The new sector to be set in manager
---@param newLevel integer | string The new level to be set in manager
---@param player Player The player instance
function world.loadMap(newSector, newLevel, player)
    -- Resets module and level
    world.sector = newSector
    world.level = newLevel

    -- Resets voiceline manager
    voicelines.reset()

    -- Single level logic for first loading
    local data = require('maps.sector' .. world.sector .. '.level' .. world.level .. '__data')
    if data.whenLoaded then data.whenLoaded() end

    -- Resets death per level
    player.levelDeaths = 0

    -- Same logic as the one when level reloaded
    world.reload(player)
end

function world.nextLevel(player)
    if world.levelsSchema[world.sector][world.level + 1] then
        -- Goes to next level
        world.level = world.level + 1
    else
        -- Initializes next sector if not initialized
        if not world.save[world.sector+1] then
            world.save[world.sector+1] = {}
        end

        -- Unlocks next sector
        world.save[world.sector+1].unlocked = true

        -- Gets the registered lowest death count (defaults to math.huge if first run in sector)
        local lowestDeathCount = (world.save[world.sector].deaths or math.huge)
        -- Saves best death count
        if player.deaths < lowestDeathCount then
            world.save[world.sector].deaths = player.deaths
        end

        -- Saves all this info
        save.saveJson("save", world.save)

        -- Takes player to sector hub after finishing a sector
        player.deaths = 0
        world.sector = "Special"
        world.level = "Hub"
    end
    world.loadMap(world.sector, world.level, player)
end

return world