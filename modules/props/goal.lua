local prop = require 'modules.props.prop'

-- Goal
---@class Goal : Prop
---@field x number X coordinates of goal
---@field y number Y coordinates of goal
---@field isCross true Makes player able of passing through goal
---@field type 'Goal' Marks to player this is a goal
local Goal = {}
Goal.__index = Goal
setmetatable(Goal, prop.Prop)

-- Creates a new goal
---@param x number X coordinates of goal
---@param y number Y coordinates of goal
---@return Goal instance
function Goal.new(x, y)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='goal' })
    ---@cast instance Goal
    instance.isCross = true
    instance.type = 'Goal'
    setmetatable(instance, Goal)
    return instance
end

return Goal