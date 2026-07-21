local props = require 'modules.props'
local assets = require 'modules.assets'

-- Custom, single level data
local data = {}

function data.whenLoaded()
    love.audio.play(assets.songs.planetX)
    assets.songs.planetX:setLooping(true)

    love.audio.play(assets.voicelines.intro)
end

local l = 0
function data.whenReloaded()
    if not assets.isPlayingAny('voicelines') then l = l + 1 end
    if l == 1 then
        love.audio.play(assets.voicelines.oopsie)
    elseif l == 2 then
        love.audio.play(assets.voicelines.cmon)
    elseif l == 5 then
        love.audio.play(assets.voicelines.loser)
    elseif l > 5 then
        local odd = math.random(4)
        if odd == 1 then
            love.audio.play(assets.voicelines.oopsie)
        elseif odd == 2 then
            love.audio.play(assets.voicelines.cmon)
        end
    end
end

-- O is object
function data.handler() end

function data.update()
    if assets.isPlayingAny('voicelines') then
        assets.songs.planetX:setVolume(0.5)
    else
        assets.songs.planetX:setVolume(1)
    end
end
return data