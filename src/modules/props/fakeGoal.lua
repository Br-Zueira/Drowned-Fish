local prop = require('modules.props.prop')
local goal = require('modules.props.goal')

-- Fake goal that moves when player is close
---@class FakeGoal : Prop
---@field x number X coordinate of goal
---@field y number Y coordinate of goal
---@field newX number The new X coordinate which the goal will move to
---@field newY number The new Y coordinate which the goal will move to
---@field radius number The radius in which the player must be close in order to the goal to move
local FakeGoal = {}
FakeGoal.__index = FakeGoal
setmetatable(FakeGoal, prop.Prop)

-- Creates a new fake goal
---@param x number X coordinate of goal
---@param y number Y coordinate of goal
---@param newX number The new X coordinate which the goal will move to
---@param newY number The new Y coordinate which the goal will move to
---@param radius number The radius in which the player must be close in order to the goal to move
---@return FakeGoal instance
function FakeGoal.new(x, y, newX, newY, radius)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='goal' })
    ---@cast instance FakeGoal
    instance.newX = newX
    instance.newY = newY
    instance.radius = radius
    setmetatable(instance, FakeGoal)
    return instance
end

-- Updates the fake goal
---@param player Player The player instance
function FakeGoal:update(_, player)
    if prop.isPlayerInRadius(self, player, self.radius) then
        goal.new(self.newX, self.newY)
        self:delete()
    end
end

return FakeGoal