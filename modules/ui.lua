local assets = require 'modules.assets'
local world = require 'modules.world'

local ui = {}

ui.eventEmitters = {}

-- Draws all ui elements
---@param player Player The player instance
---@param paused boolean Tells if game is paused
function ui.draw(player, paused)
    -- Resets the event limiter list
    ui.eventEmitters = {}

    local f = assets.fonts.VT323
    love.graphics.setFont(f)
    ui.drawDeathCounter(player, f)
    ui.drawLevelList(f)
    if paused then ui.drawPauseMenu(f) end
end

-- Draws the death counter
---@param player Player The player instance
---@param f any The font source
function ui.drawDeathCounter(player, f)
    -- Color for text
    love.graphics.setColor(1, 1, 1, 1)

    -- Shows info for total death counter
    local deathsText = 'Deaths: ' .. player.deaths
    local marginX = 10
    local marginYDeaths = 10
    local scaleFactor = 2
    love.graphics.print(deathsText, marginX, marginYDeaths, 0, scaleFactor, scaleFactor)

    -- Shows info for level death counter right below the bigger total death counter
    if world.sector == "Special" then return end
    local levelDeathsText = 'Level deaths: ' .. player.levelDeaths
    local marginYLevelDeaths = marginYDeaths + f:getHeight()*scaleFactor
    love.graphics.print(levelDeathsText, marginX, marginYLevelDeaths)
end

-- Draws the level list element
---@param f any The font source
function ui.drawLevelList(f)
    -- Changes the display name to be cooler
    local sector = world.sector
    if sector == "Special" then
        sector = "UNKNOWN"
    end

    -- Text for sector
    local secText = 'Sector: ' .. sector
    local posX = (VW - f:getWidth(secText)) / 2 -- Centralizes text
    local posY = VH - f:getHeight() - 8 -- Sits at bottom with a small margin
    love.graphics.setColor(1, 1, 1, 0.75) -- White
    love.graphics.print(secText, posX, posY)

    -- As those levels contain string instead of numeric names, they'd break the rest of the UI
    if world.sector == "Special" then return end

    -- Levels and sectors
    local squareSize = 32
    local margin = 32
    local padding = 16

    -- Gets total levels from current sector
    local levelAmount = #world.levelsSchema[world.sector]

    -- Back rectangle settings
    local rectThickness = 16

    -- Calculates total width and left gap in order to get the position of each level square
    local totalWidth = (levelAmount * squareSize) + (padding * (levelAmount - 1))
    local leftGap = ((VW - totalWidth) / 2)

    -- PosY for level squares
    local posY = VH - squareSize - margin

    -- Back rectangle position
    local rectPosX = leftGap + (squareSize / 2)
    local rectWidth= (levelAmount - 1) * (squareSize + padding) - (squareSize / 2)
    local rectPosY = posY + (squareSize - rectThickness) / 2

    -- Draws the rectangle itself
    love.graphics.setColor(0, 0, 1, 0.75)
    love.graphics.rectangle('fill', rectPosX, rectPosY, rectWidth, rectThickness)

    -- Draws each square
    for i = 1, levelAmount do
        -- X position of each square
        local posX = leftGap + ((i - 1) * (squareSize + padding))
        -- If square is a past level
        if i < world.level then
            -- Glass cyan
            love.graphics.setColor(0, 0.4, 0.6, 0.75)
            love.graphics.rectangle('fill', posX, posY, squareSize, squareSize)
        -- If square is the current level
        elseif i == world.level then
            -- White
            love.graphics.setColor(1, 1, 1, 0.9)
            love.graphics.rectangle('fill', posX, posY, squareSize, squareSize)

            -- Diamond-shaped outline
            local size = squareSize + 2
            love.graphics.push() -- Saves current camera settings
            love.graphics.translate(posX + (squareSize/2), posY + (squareSize/2)) -- Move origin to square's center
            love.graphics.rotate(math.rad(45)) -- Rotate 45 degrees into a diamond
            love.graphics.setColor(1, 0.5, 0, 1) -- Orange
            love.graphics.setLineWidth(2) -- Makes border thicker
            love.graphics.rectangle('line', -size/2, -size/2, size, size) -- Border itself
            love.graphics.setLineWidth(1) -- Reset back to default line width
            love.graphics.pop() -- Recovers original camera settings
        -- If square is a later level
        else
            -- Blue-ish gray
            love.graphics.setColor(0.2, 0.2, 0.3, 0.75)
            love.graphics.rectangle('fill', posX, posY, squareSize, squareSize)
        end
    end
end

ui.pauseMenuInfo = {
    textColor = {0, 0, 0, 1},
    sizeX = 650, sizeY = 400
}

-- Draws the pause menu
---@param f any The font source
function ui.drawPauseMenu(f)
    ui.drawPauseBG()
    ui.drawVolumeControler(f)
    ui.drawButtons(f)
end

function ui.drawPauseBG()
    -- The whole screen overlay to darker the game, slightly green for terminal style
    love.graphics.setColor(0, 0.1, 0.0, 0.5)
    love.graphics.rectangle('fill', 0, 0, VW, VH)

    -- Aliases
    local sizeX, sizeY = ui.pauseMenuInfo.sizeX, ui.pauseMenuInfo.sizeY

    -- Centralizes background
    ui.pauseMenuInfo.gapX = (VW-sizeX)/2
    ui.pauseMenuInfo.gapY = (VH-sizeY)/2

    -- Draws background
    love.graphics.setColor(0, 0.5, 0, 0.75)
    love.graphics.rectangle('fill', ui.pauseMenuInfo.gapX,ui.pauseMenuInfo.gapY, sizeX, sizeY)

    -- Draws the 'Game paused' thing
    local offset = 16
    local scaleFac = 1.5
    love.graphics.setColor(ui.pauseMenuInfo.textColor)
    love.graphics.printf(
        "Game paused", -- Text
        0, ui.pauseMenuInfo.gapY + offset, -- Start
        math.floor(VW/scaleFac), -- Maximum Width
        'center', -- Align method
        0, -- Rotation
        scaleFac, scaleFac -- SX and SY
    )
end

-- Helper to see if element is being hovered
---@param x number
---@param y number
---@param width number
---@param height number
local function isHovered(x, y, width, height)
    local mX, mY = love.mouse.getPosition()
    return mX >= x and mX <= x + width and
            mY >= y and mY <= y + height
end

-- Draws the audio channels volume controler
---@param f any The font source
function ui.drawVolumeControler(f)
    -- X limit of background
    local borderX = ui.pauseMenuInfo.gapX + ui.pauseMenuInfo.sizeX

    -- Each square size
    local squareSize = 32

    -- Color schema for squares, booleans as index to let logic simple and avoid if hell
    local squareColors = {
        [false] = { -- Unchecked
            [false] = {0, 0.5, 0.1, 1}, -- Unhovered
            [true] = {0, 0.5, 0.1, 0.8}, -- Hovered
        },
        [true] = { -- Checked
            [false] = {0, 0.1, 0, 1}, -- Unhovered
            [true] = {0, 0.1, 0, 0.8} -- Hovered
        }
    }

    local textColors = {
        [false] = { -- Unselected
            [false] = ui.pauseMenuInfo.textColor, -- Unhovered
            [true] = {0, 0, 0, 0.5}, -- Hovered
        },
        [true] = { -- Selected
            [false] = {0, 0.25, 0, 1}, -- Unhovered
            [true] = {0, 0.25, 0, 0.8} -- Hovered
        }
    }

    -- X margin of square 
    local squarePaddingX = 16

    -- Square X coordinates
    local squareX = borderX - squarePaddingX - squareSize

    -- Limit of square label
    local textLimitX = squareX - squarePaddingX - ui.pauseMenuInfo.gapX

    -- Padding between options
    local paddingY = 32

    -- Margin between first element and upper border of background
    local marginY = 100

    -- Volume channels
    local volumes = {{display="Music", id="songs"}, {display="SFX", id="sfx"}, {display="Voicelines", id="voicelines"}}
    for i, v in ipairs(volumes) do
        -- Square Y position
        local squareY = ui.pauseMenuInfo.gapY + (paddingY + squareSize) * (i - 1) + marginY

        -- Gets user color
        local checked = assets.volume[v.id].muted
        local hovered = isHovered(squareX, squareY, squareSize, squareSize)
        local color = squareColors[checked][hovered]

        -- Draws the square
        love.graphics.setColor(color)
        love.graphics.rectangle(
            "fill",
            squareX, squareY,
            squareSize, squareSize
        )


        -- Sound channel label
        local displayValue = assets.volume[v.id].volume * 100 .. "%"
        local displayText = v.display .. " [" .. displayValue .. "]"

        -- Y coordinates of label
        local textY = squareY + (squareSize - f:getHeight())/2

        -- Prints label
        hovered = isHovered(ui.pauseMenuInfo.gapX, textY, textLimitX, f:getHeight())
        local selected = false
        color = textColors[selected][hovered]
        love.graphics.setColor(color)
        love.graphics.printf(displayText, ui.pauseMenuInfo.gapX, textY, textLimitX, 'right')

        -- Puts square in event emitters list
        table.insert(ui.eventEmitters, {
            x=squareX, y=squareY,
            width=squareSize, height=squareSize,
            type="square", properties={id=v.id}
        })

        table.insert(ui.eventEmitters, {
            x=ui.pauseMenuInfo.gapX, y=textY,
            width=textLimitX, height=textLimitX,
            type="volumeControler", properties={id=v.id}
        })
    end
end

-- Draws the menu screen buttons
---@param f any The font source
function ui.drawButtons(f)
    -- All info needed to render the button
    local sizeX, sizeY = 150, 50
    local buttonColor = {0, 0.5, 0.1, 1}
    local buttonColorHover = {0, 0.5, 0.1, 0.8}
    local x = ui.pauseMenuInfo.gapX + (ui.pauseMenuInfo.sizeX - sizeX)/2 -- Centralizes button
    local gapY = (ui.pauseMenuInfo.gapY + ui.pauseMenuInfo.sizeY) - sizeY -- Puts it relative to the bottom
    local offset = 50 -- Offset from the menu bottom

    local y = gapY - offset -- Y coordinates of button

    if isHovered(x, y, sizeX, sizeY) then
        love.graphics.setColor(buttonColorHover)
    else
        love.graphics.setColor(buttonColor)
    end

    love.graphics.rectangle('fill', x, y, sizeX, sizeY, 10, 10)

    -- Button label
    local text = "Go back to hub"
    local height = f:getHeight()
    love.graphics.setColor(ui.pauseMenuInfo.textColor)
    love.graphics.printf(
        text,
        ui.pauseMenuInfo.gapX,
        y + height/2, -- Centralizes text relative to the button
        ui.pauseMenuInfo.sizeX,
        'center' -- Button covers the whole menu width to be 100% centralized
    )

    -- Saves button in event emitters
    table.insert(ui.eventEmitters, {
        x=x, y=y,
        width=sizeX, height=sizeY,
        type="button", properties={ onclick="goToHub" }
    })
end

-- Manages mouse interaction with menu
---@param player Player The player instance
function ui.mouseControler(player)
    for _, e in ipairs(ui.eventEmitters) do
        if isHovered(e.x, e.y, e.width, e.height) then
            if e.type == "square" then
                -- Inverts muted state and updates the volume of the channels
                assets.volume[e.properties.id].muted = not assets.volume[e.properties.id].muted
                assets.updateVolume()
            elseif e.type == "button" and e.properties.onclick == "goToHub" then
                -- Goes to hub
                world.loadMap("Special", "Hub", player)
                -- Tells game to unpause and mute voicelines to avoid some bizarre quirks
                return { execute="muteVL", unpause=true }
            end
        end
    end
end

return ui