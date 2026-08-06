local prop = require 'modules.props.prop'

-- Booster that makes player bounce
---@class Booster : Prop
---@field speed number
---@field degrees number
---@field isTrigger true
local Booster = {}
Booster.__index = Booster
setmetatable(Booster, prop.Prop)

-- Creates new booster
---@param x number X coordinates of booster
---@param y number Y coordinates of booster
---@param speed number Speed to boost the player
---@param degrees number Rotation, in degrees (default is 0) of the booster
function Booster.new(x, y, speed, degrees)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='booster'})
    setmetatable(instance, Booster)
    ---@cast instance Booster
    instance.isTrigger = true
    instance.speed = speed
    instance.degrees = degrees or 0
    return instance
end

local function colFilter(_, other)
    if other.type == 'Player' then
        return 'cross'
    end
    return nil
end

function Booster:update(_, player)
    local _, _, cols, len = World:check(self, self.x, self.y, colFilter)
    for i = 1, len do
        local col = cols[i]
        if col.other == player then
            local rad = math.rad(self.degrees)
            local velX = self.speed * math.sin(rad)
            local velY = -(self.speed * math.cos(rad)) -- VelY is inverted because in LOVE, bigger Y is lower
            player.boostedX = velX
            player.velY = velY
        end
    end
end

return Booster