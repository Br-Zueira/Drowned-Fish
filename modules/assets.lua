--- The asset manager
local assets = {
    images = {},
    fonts = {},
    sfx = {},
    voicelines = {},
    songs = {}
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
    -- Misc
    assets.loadImage('background', 'background.jpg')
    assets.loadImage('player', 'player.png')

    -- Props
    assets.loadImage('tile', 'test.png')
    assets.loadImage('spike', 'spike.png')
    assets.loadImage('goal', 'goal.png')
    assets.loadImage('saw', 'saw.png')
    assets.loadImage('placeholder', 'placeholder.png')
    assets.loadImage('spring', 'spring.png')
    assets.loadImage('booster', 'booster.png')

    -- Voicelines
    assets.loadVoiceLine('intro', 'intro.wav')
    assets.loadVoiceLine('oopsie', 'oopsie.wav')
    assets.loadVoiceLine('loser', 'loser.wav')
    assets.loadVoiceLine('cmon', 'cmon.wav')
    assets.loadVoiceLine('gma', 'gma.wav')
    assets.loadVoiceLine('portals', 'portals.wav')

    -- Song
    assets.loadSong('planetX', 'Imphenzia - Discovery of Planet X.ogg')

    -- Font
    assets.loadFont('VT323', 'VT323-Regular.ttf', 24)
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

    -- Gets the current song
    local s = assets.songs[assets.songManager.keys[assets.songManager.current]]
    if not assets.isPlayingAny('songs') then
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
end

assets.isAudioPaused = false
assets.allPaused = nil

---@param paused boolean Tells whether the game is paused
function assets.pauseManager(paused)
    if paused then
        if assets.isAudioPaused then return end
        assets.allPaused = love.audio.pause()
        assets.isAudioPaused = true
    else
        if not assets.isAudioPaused or not assets.allPaused then return end
        love.audio.play(assets.allPaused)
        assets.isAudioPaused = false
    end
end

return assets