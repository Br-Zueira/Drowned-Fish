local world = require 'modules.world'
local assets = require 'modules.assets'
local Player = require 'modules.player'
local ui = require 'modules.ui'

local player
local paused = false
local wasPausePressed = false

-- Lua debugger extension support
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- Love standard implementations
function love.load(args)
    -- Window dimensions
    VW = love.graphics.getWidth()
    VH = love.graphics.getHeight()

    -- Tiling
    TileSize = 32

    -- Create necessary objects
    player = Player.new()

    -- Load assets
    assets.load()

    ---@type string | integer
    local level = "Hub"
    ---@type string | integer
    local sector = "Special"
    for _, param in ipairs(args) do
        local sectorParam = tonumber(param:match("^%-%-sector=(%d+)$"))
        local levelParam = tonumber(param:match("^%-%-level=(%d+)$"))
        if param == "--dev-map" then
            sector = 0
            level = 1
        elseif sectorParam then
            sector = sectorParam
        elseif levelParam then
            level = levelParam
        end
    end

    world.loadMap(sector, level, player)

end

---@param dt number Delta time for each rendered frame
function love.update(dt)
    dt = math.min(dt, 1/30)
    if love.keyboard.isDown("p") then
        if not wasPausePressed then
            paused = not paused
        end
        wasPausePressed = true
    else
        wasPausePressed = false
    end

    if not paused then
        world.update(dt, player)
        player:update(dt)
    end

    assets.songManager.update(paused)
end

function love.draw()
    -- Resets color
    love.graphics.setColor(1, 1, 1, 1)

    -- Render scenary
    world.draw()

    -- Render player
    player:draw()

    -- Render UI
    ui.draw(player, paused)
end