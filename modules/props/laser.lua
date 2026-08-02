local prop = require 'modules.props.prop'

---@class Laser : Prop
---@field group number
---@field isDisabled boolean
---@field intermiTime number | nil
---@field timer number | nil
---@field isFake boolean
local Laser = {}
Laser.__index = Laser
setmetatable(Laser, prop.Prop)

local laserRay = {}
laserRay.__index = laserRay
function laserRay.new(parent1, parent2)
    local instance = {}
    setmetatable(instance, laserRay)
    instance.parent1 = parent1
    instance.parent2 = parent2
    instance.isInvisible = true
    table.insert(prop.propList, instance)
    return instance
end

local function colFilter()
    return 'cross'
end

function laserRay:update(_, player)
    if self.parent1.isDisabled or self.parent2.isDisabled
     or self.parent1.isFake or self.parent2.isFake then
        return
    end
    local cols, len = World:querySegment(
        self.parent1.x + TileSize/2, self.parent1.y + TileSize/2,
        self.parent2.x + TileSize/2, self.parent2.y + TileSize/2,
        colFilter
    )
    for i = 1, len do
        local other = cols[i]
        if other == player then
            player:death()
            return
        end
    end
end

function laserRay:draw()
    if self.parent1.isDisabled or self.parent2.isDisabled then return end
    love.graphics.setColor(1, 0, 0, 0.8)
    love.graphics.setLineWidth(8)
    love.graphics.line(
        self.parent1.x + TileSize/2, self.parent1.y + TileSize/2,
        self.parent2.x + TileSize/2, self.parent2.y + TileSize/2
    )
    love.graphics.setColor(1, 1, 1, 1)
end

---@param x number
---@param y number
---@param group number
---@param isDisabled boolean | nil
---@param intermiTime number | nil
function Laser.new(x, y, group, isDisabled, intermiTime, isFake)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='laser' })
    ---@cast instance Laser
    setmetatable(instance, Laser)
    instance.group = group
    instance.isDisabled = not not isDisabled -- Turns nil into false and keeps false and true unchanged
    instance.isFake = not not isFake
    if intermiTime then
        instance.intermiTime = intermiTime
        instance.timer = intermiTime
    end
    if instance.isDisabled then return instance end
    for _, p in ipairs(prop.propList) do
        if getmetatable(p) == Laser and p.group == instance.group then
            laserRay.new(instance, p)
        end
    end
    return instance
end

function Laser:update(dt)
    if not self.intermiTime then return end
    self.timer = math.max(0, self.timer - dt)
    if self.timer == 0 then
        self.isDisabled = not self.isDisabled
        self.timer = self.intermiTime
    end
end

return Laser