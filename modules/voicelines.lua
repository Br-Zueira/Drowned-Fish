local assets = require 'modules.assets'

---@class voicelines
---@field v table The list of voicelines
---@field step integer The current step
local voicelines = {
    ---@type table[]
    v = {},
    step = 0
}

-- Resets the voiceline manager
function voicelines.reset()
    voicelines.v = {}
    voicelines.step = 0
end

-- This function adds a voiceline to the list
---@param name string The voiceline name
---@param step integer The step in which the voiceline will be played
---@param odd? integer The chance of the voiceline being played (odd/of). If undefined, it's 1
---@param of? integer The chance of the voiceline being played (odd/of). If undefined, it's 1
---@param isStepBiggerThan? boolean If true, the voiceline will be played if target step is bigger instead of equal to current step
function voicelines.add(name, step, odd, of, isStepBiggerThan)
    local v = {
        step=step, name=name,
        odd=odd or 1, of=of or 1,
        isStepBiggerThan=isStepBiggerThan
    }
    table.insert(voicelines.v, v)
end

-- Updates the voiceline manager
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