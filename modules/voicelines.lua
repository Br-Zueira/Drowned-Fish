local assets = require 'modules.assets'

local voicelines = {
    v = {},
    step = 0
}

function voicelines.reset()
    voicelines.v = {}
    voicelines.step = 0
end

function voicelines.add(name, step, odd, of, isStepBiggerThan)
    local v = {
        step=step, name=name,
        odd=odd or 1, of=of or 1,
        isStepBiggerThan=isStepBiggerThan
    }
    table.insert(voicelines.v, v)
end

function voicelines.update()
    -- Only updates if not already playing voiceline
    if assets.isPlayingAny('voicelines') then return end

    -- Increases step for voicelines
    voicelines.step = voicelines.step + 1
    for _, v in ipairs(voicelines.v) do

        -- Sees if it's the step of playing
        local hasReachedStep = (v.step == voicelines.step) or (v.isStepBiggerThan and voicelines.step > v.step)

        -- If reached step and odds are favorable, plays audio
        if hasReachedStep and math.random(v.of) == v.odd then
            local vc = assets.voicelines[v.name]
            if vc then
                love.audio.play(vc)
                return
            end
        end
    end
end

return voicelines