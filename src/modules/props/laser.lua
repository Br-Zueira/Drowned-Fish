local prop = require 'modules.props.prop'

---@class Laser : Prop
---@field group number
---@field isDisabled boolean
---@field intermiTime number | nil
---@field timer number | nil
---@field isFake boolean
---@field type 'Laser'
local Laser = {}
Laser.__index = Laser
setmetatable(Laser, prop.Prop)

---@class laserRay
---@field parent1 Laser
---@field parent2 Laser
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

-- Avoids stucking on anything
local function colFilter()
    return 'cross'
end

function laserRay:update(_, player)
    -- Only checks for collisions if parent emitters aren't disabled and aren't fake
    if self.parent1.isDisabled or self.parent2.isDisabled
     or self.parent1.isFake or self.parent2.isFake then
        return
    end

    -- Checks for collisions in a direct line (TileSize/2 centralizes the beam)
    local cols, len = World:querySegment(
        self.parent1.x + TileSize/2, self.parent1.y + TileSize/2,
        self.parent2.x + TileSize/2, self.parent2.y + TileSize/2,
        colFilter
    )
    for i = 1, len do
        local other = cols[i]
        if other == player then
            -- Kills player
            player:death()
            return
        end
    end
end

function laserRay:draw()
    -- Only draws ray if parents aren't disabled
    if self.parent1.isDisabled or self.parent2.isDisabled then return end

    -- Sets color (pure red, a bit transparent)
    love.graphics.setColor(1, 0, 0, 0.5)

    -- Makes the line thicker
    local width = 16 + math.sin(love.timer.getTime() * 20) * 2
    love.graphics.setLineWidth(width)

    -- Draws the line itself (TileSize/2 centralizes the beam)
    love.graphics.line(
        self.parent1.x + TileSize/2, self.parent1.y + TileSize/2,
        self.parent2.x + TileSize/2, self.parent2.y + TileSize/2
    )

    -- Sets color (pure white)
    love.graphics.setColor(1, 1, 1, 1)

    -- Makes the line thinner
    love.graphics.setLineWidth(6)

    -- Draws the line itself (TileSize/2 centralizes the beam)
    love.graphics.line(
        self.parent1.x + TileSize/2, self.parent1.y + TileSize/2,
        self.parent2.x + TileSize/2, self.parent2.y + TileSize/2
    )

    -- Resets line width back to default
    love.graphics.setLineWidth(1)
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
    instance.isDisabled = isDisabled == true -- Turns nil into false and keeps false and true unchanged
    instance.isFake = isFake == true
    instance.type = 'Laser'
    if intermiTime then
        instance.intermiTime = intermiTime
        instance.timer = intermiTime
    end
    for _, p in ipairs(prop.propList) do
        if p.type == 'Laser' and p.group == instance.group then
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