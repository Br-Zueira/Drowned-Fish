local world = require 'modules.world'
local assets = require 'modules.assets'
local Player = require 'modules.player'

local player

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

    -- Song
    love.audio.play(assets.songs.planetX)
    assets.songs.planetX:setLooping(true)

    local level = 1
    local sector = 1
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
    world.update(dt, player)
    player:update(dt)
end

function love.draw()
    -- Render scenary
    world.draw()

    -- Render player
    player:draw()

    -- Render death counter
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(assets.fonts.VT323)
    love.graphics.print('Deaths: ' .. player.deaths, 10, 10, 0, 2, 2)
end