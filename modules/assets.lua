local assets = {
    images = {},
    fonts = {},
    sfx = {},
    voicelines = {},
    songs = {}
}

-- Loaders for each type of asset in the game

function assets.loadImage(name, file)
    assets.images[name] = love.graphics.newImage('assets/images/' .. file)
end

function assets.loadFont(name, file, size)
    assets.fonts[name] = love.graphics.loadFont('assets/fonts/' .. file, size)
end

function assets.loadSfx(name, file)
    assets.sfx[name] = love.audio.newSource('assets/sfx/' .. file, 'static')
end

function assets.loadSong(name, file)
    assets.songs[name] = love.audio.newSource('assets/songs/' .. file, 'stream')
end

function assets.loadVoiceLine(name, file)
    assets.voicelines[name] = love.audio.newSource('assets/voicelines/' .. file, 'static')
end

-- Helper to stop an specific type of audio
function assets.stopAudio(type)
    if assets[type] then
        for _, source in pairs(assets[type]) do
            source:stop()
        end
    end
end

-- Helper to set volume for a whole type of audio
function assets.setVolume(type, vol)
    if assets[type] then
        for _, source in pairs(assets[type]) do
            source:setVolume(vol)
        end
    end
end

-- Helper to see if there's any audio of a type playing in a given moment
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
    assets.loadImage('tile', 'test.png')
    assets.loadImage('spike', 'spike.png')
    assets.loadImage('goal', 'goal.png')
    assets.loadImage('saw', 'saw.png')

    assets.loadVoiceLine('intro', 'intro.wav')
    assets.loadVoiceLine('oopsie', 'oopsie.wav')
    assets.loadVoiceLine('loser', 'loser.wav')
    assets.loadVoiceLine('cmon', 'cmon.wav')

    assets.loadSong('planetX', 'Imphenzia - Discovery of Planet X.ogg')
end

return assets