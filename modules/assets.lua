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

return assets