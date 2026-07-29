local assets = require 'modules.assets'
local world = require 'modules.world'

local ui = {}

-- Draws all ui elements
---@param player Player The player instance
---@param paused boolean Tells if game is paused
function ui.draw(player, paused)
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

-- Draws the pause menu
---@param f any The font source
function ui.drawPauseMenu(f)
    -- Slightly green for terminal style
    love.graphics.setColor(0, 0.1, 0.0, 0.5)
    love.graphics.rectangle('fill', 0, 0, VW, VH)
end

return ui