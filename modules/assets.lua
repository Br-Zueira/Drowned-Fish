local assets = {
    images = {},
    fonts = {},
    audio = {}
}

function assets.loadImage(name, path)
    assets.images[name] = love.graphics.newImage(path)
end

function assets.loadFont(name, path, size)
    assets.fonts[name] = love.graphics.loadFont(path, size)
end

function assets.loadAudio(name, path, isOST)
    local type = 'static'
    if isOST then
        type = 'stream'
    end
    assets.audio[name] = love.audio.newSource(path, type)
    assets.audio[name]:setVolume(1)
end

function assets.load()
    assets.loadImage('tile', '/assets/images/test.png')
    assets.loadImage('spike', '/assets/images/spike.png')
    assets.loadImage('goal', '/assets/images/goal.png')

    love.audio.setVolume(1)
    assets.loadAudio('intro', '/assets/audio/intro.wav', false)
    assets.loadAudio('oopsie', '/assets/audio/oopsie.wav', false)
    assets.loadAudio('loser', '/assets/audio/loser.wav', false)
    assets.loadAudio('cmon', '/assets/audio/cmon.wav', false)
end

return assets