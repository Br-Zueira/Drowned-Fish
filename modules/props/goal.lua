local prop = require 'modules.props.prop'

-- Goal
local Goal = {}
Goal.__index = Goal
setmetatable(Goal, prop.Prop)

function Goal.new(x, y)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='goal' })
    instance.isTrigger = true
    instance.type = 'Goal'
    setmetatable(instance, Goal)
    return instance
end

return Goal