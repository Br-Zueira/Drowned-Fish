local save = require "modules.save"

-- The asset manager
local assets = {
    images = {},
    fonts = {},
    sfx = {},
    voicelines = {},
    songs = {},
    backgrounds = {},
    particles = {}
}

-- Loads volume settings, or create from scratch if no settings
assets.volume = save.loadJson('settings') or {
    songs = {muted=false, volume=1},
    sfx = {muted=false, volume=1},
    voicelines = {muted=false, volume=1}
}

-- Loaders for each type of asset in the game

---@param name string The name of the asset
---@param file string The file name
function assets.loadImage(name, file)
    assets.images[name] = love.graphics.newImage('assets/images/' .. file)
end

---@param name string The name of the asset
---@param file string The file name
---@param size number The font size
function assets.loadFont(name, file, size)
    assets.fonts[name] = love.graphics.newFont('assets/fonts/' .. file, size)
    assets.fonts[name]:setFilter('nearest', 'nearest')
end

---@param name string The name of the asset
---@param file string The file name
function assets.loadSfx(name, file)
    assets.sfx[name] = love.audio.newSource('assets/sfx/' .. file, 'static')
end

---@param name string The name of the asset
---@param file string The file name
function assets.loadSong(name, file)
    assets.songs[name] = love.audio.newSource('assets/songs/' .. file, 'stream')
end

---@param name string The name of the asset
---@param file string The file name
function assets.loadVoiceLine(name, file)
    assets.voicelines[name] = love.audio.newSource('assets/voicelines/' .. file, 'static')
end

---@param name string The name of the asset
---@param file string The file name
function assets.loadBackground(name, file)
    assets.backgrounds[name] = love.graphics.newImage('assets/backgrounds/' .. file)
    assets.backgrounds[name]:setFilter('nearest', 'nearest')
end

-- Creates new particle system
---@param name string Name of particle system
---@param colorschema table Color schema for particle, defined as {r, g, b, a}
---@param maxParticles integer Maximum amount of particles that can coexist
---@param emissionrate integer Particles per second
---@param particleLifeTimeMin number Minimum a particle can live
---@param particleLifeTimeMax number Maximum a particle can live
---@param speedMin number Minimum speed for particle
---@param speedMax number Maximum speed for particle
---@param spread number Angle in radians in which the particle system can emit particles
---@param sizeStart number The starting size for particles
---@param sizeEnd number The end size for particles
function assets.newParticleSystem(
    name, colorschema,
    maxParticles, emissionrate,
    particleLifeTimeMin, particleLifeTimeMax,
    speedMin, speedMax,
    spread, sizeStart, sizeEnd
)
    local data = love.image.newImageData(1, 1)
    data:setPixel(0, 0, unpack(colorschema))
    local particle = love.graphics.newImage(data)
    local pSystem = love.graphics.newParticleSystem(particle, maxParticles)
    pSystem:setEmissionRate(emissionrate)
    pSystem:setParticleLifetime(particleLifeTimeMin, particleLifeTimeMax)
    pSystem:setSpeed(speedMin, speedMax)
    pSystem:setSpread(spread)
    pSystem:setSizes(sizeStart, sizeEnd)
    assets.particles[name] = pSystem
end

-- Helper to stop an specific type of audio
---@param type string The type of audio (sfx, voicelines or songs)
function assets.stopAudio(type)
    if assets[type] then
        for _, source in pairs(assets[type]) do
            source:stop()
        end
    end
end

-- Helper to set volume for a whole type of audio
---@param type string The type of audio (sfx, voicelines or songs)
---@param vol number The volume number (between 0 and 1) to be set
function assets.setVolume(type, vol)
    if assets[type] then
        for _, source in pairs(assets[type]) do
            source:setVolume(vol)
        end
    end
end

-- Helper to see if there's any audio of a type playing in a given moment
---@param type string The type of audio (sfx, voicelines or songs)
function assets.isPlayingAny(type)
    -- Avoids nil related crashes
    if not assets[type] then return false end

    -- Does the verification
    for _, source in pairs(assets[type]) do
        if source:isPlaying() then
            return true
        end
    end
    return false
end

-- Loads every game asset
function assets.load()
    -- Backgrounds
    assets.loadBackground('cold', 'cold.jpg')
    assets.loadBackground('deep', 'deep.jpg')
    assets.loadBackground('galaxycore', 'galaxycore.jpg')
    assets.loadBackground('legacy', 'legacy.jpg')
    assets.loadBackground('lunarground', 'lunarground.jpg')
    assets.loadBackground('purpleish', 'purpleish.jpg')
    assets.loadBackground('redish', 'redish.jpg')

    -- Player
    assets.loadImage('player', 'player.png')

    -- Props
    assets.loadImage('tile', 'test.png')
    assets.loadImage('spike', 'spike.png')
    assets.loadImage('goal', 'goal.png')
    assets.loadImage('saw', 'saw.png')
    assets.loadImage('placeholder', 'placeholder.png')
    assets.loadImage('spring', 'spring.png')
    assets.loadImage('booster', 'booster.png')
    assets.loadImage('laser', 'laser.png')

    -- Voicelines
    assets.loadVoiceLine('intro', 'intro.wav')
    assets.loadVoiceLine('oopsie', 'oopsie.wav')
    assets.loadVoiceLine('loser', 'loser.wav')
    assets.loadVoiceLine('cmon', 'cmon.wav')
    assets.loadVoiceLine('gma', 'gma.wav')
    assets.loadVoiceLine('portals', 'portals.wav')

    -- Songs
    assets.loadSong('planetX', 'Imphenzia - Discovery of Planet X.ogg')
    assets.loadSong('leavingOutpost', 'Imphenzia - Leaving the Outpost.ogg')
    assets.loadSong('auraAlien', 'Imphenzia - Aura of the Alien.ogg')

    -- SFX
    assets.loadSfx('jump', 'jump.mp3')
    assets.loadSfx('landing', 'landing.mp3')
    assets.loadSfx('death', 'death.mp3')
    assets.loadSfx('portal', 'portal.mp3')
    assets.loadSfx('button', 'button.mp3')
    assets.loadSfx('steps', 'steps.mp3')
    assets.loadSfx('pause', 'pause.mp3')
    assets.loadSfx('unpause', 'unpause.mp3')

    -- Font
    assets.loadFont('VT323', 'VT323-Regular.ttf', 24)

    -- Particle systems
    assets.newParticleSystem(
        'deathPS', {1, 1, 0, 1}, 
        100, 0, 0.25, 0.5, 200, 400, math.pi*2, 4, 0
    )
    assets.newParticleSystem(
        'goalPS', {0, 0.25, 1, 1},
        100, 0, 0.25, 0.5, 200, 400, math.pi*2, 4, 0
    )
    assets.newParticleSystem(
        'teleportPS', {0.5, 0, 0.5, 1},
        100, 0, 0.5, 1, 50, 100, math.pi*2, 2, 0
    )
end

-- Song manager status
assets.songManager = {}
assets.songManager.current = 1
assets.songManager.next = 1

-- Uses this way just because a key-value table can't be accessed by index
function assets.songManager.load()
    assets.songManager.keys = {}
    for key, _ in pairs(assets.songs) do
        table.insert(assets.songManager.keys, key)
    end
end

-- Updates the song manager
function assets.songManager.update()
    -- Avoids crashed if no songs
    if #assets.songManager.keys == 0 then return end

    -- Only updates if not playing any songs and audio not paused
    if assets.isPlayingAny('songs') or assets.isAudioPaused then return end

    -- Gets the current song
    local s = assets.songs[assets.songManager.keys[assets.songManager.current]]

    -- Changes current song for next one
    s = assets.songs[assets.songManager.keys[assets.songManager.next]]
    assets.songManager.current = assets.songManager.next

    -- Plays the song
    s:play()

    -- Gets next index to be played
    if #assets.songManager.keys == 1 then return end -- Avoids infinite loop (with single song, next will always be equal to current)
    repeat
        assets.songManager.next = math.random(#assets.songManager.keys)
    until assets.songManager.next ~= assets.songManager.current -- Avoids a song playing more than once straight
end

-- Manages audio pausing and unpausing
assets.isAudioPaused = false
assets.allPaused = nil

-- Pauses and unpauses audio along with game
---@param paused boolean Tells whether the game is paused
function assets.pauseManager(paused)
    if paused then
        -- If audio is already paused, there's no need to pause it
        if assets.isAudioPaused then return end

        -- Pauses all playing audio and saves it for later reference
        assets.stopAudio('sfx')
        assets.allPaused = love.audio.pause()

        -- Plays pause sfx
        assets.sfx.pause:clone():play()

        -- Marks that audio is already paused
        assets.isAudioPaused = true
    else
        -- If audio is not paused, there's no need to unpause it
        -- "If not assets.allPaused then return" avoids crashes
        if not assets.isAudioPaused or not assets.allPaused then return end

        -- Unpauses all paused audio
        love.audio.play(assets.allPaused)

        -- Plays unpause sfx
        assets.sfx.unpause:clone():play()

        -- Cleans state
        assets.allPaused = {}

        -- Marks that audio is not paused anymore
        assets.isAudioPaused = false
    end
end

-- Updates every audio channel volume to match assets.volume settings
function assets.updateVolume()
    for channelName, channel in pairs(assets.volume) do
        if channel.muted then
            assets.setVolume(channelName, 0)
        else
            assets.setVolume(channelName, channel.volume)
        end
    end
    -- Saves volume settings
    save.saveJson('settings', assets.volume)
end

return assets