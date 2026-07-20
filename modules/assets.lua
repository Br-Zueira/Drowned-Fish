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
end

function assets.load()
    assets.loadImage('tile', '/assets/images/test.png')
    assets.loadImage('spike', '/assets/images/spike.png')
    assets.loadImage('goal', '/assets/images/goal.png')
end

return assets