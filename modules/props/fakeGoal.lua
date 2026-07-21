local prop = require('modules.props.prop')
local goal = require('modules.props.goal')

-- Fake goal that moves when player is close
local FakeGoal = {}
FakeGoal.__index = FakeGoal
setmetatable(FakeGoal, prop.Prop)

function FakeGoal.new(x, y, newX, newY, radius)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='goal' })
    instance.newX = newX
    instance.newY = newY
    instance.radius = radius
    setmetatable(instance, FakeGoal)
    return instance
end

function FakeGoal:update(_, player)
    if prop.isPlayerInRadius(self, player, self.radius) then
        goal.new(self.newX, self.newY)
        self:delete()
    end
end

return FakeGoal