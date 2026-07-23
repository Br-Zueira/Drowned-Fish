local world = require 'modules.world'
local assets = require 'modules.assets'
local Player = require 'modules.player'

local player

-- Lua debugger extension support
if os.getenv("LOCAL_LUA_DEBUGGER_VSCODE") == "1" then
    require("lldebugger").start()
end

-- Love standard implementations
function love.load()
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

    world.loadMap(1, player)

end

---@param dt number Delta time for each rendered frame
function love.update(dt)
    player:update(dt)
    world.update(dt, player)
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