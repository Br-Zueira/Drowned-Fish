local prop = require 'modules.props.prop'

-- Portal that teleports player to its pair
---@class Portal : Prop
---@field x number X coordinate of portal
---@field y number Y coordinate of portal
---@field pair integer Pair of portal
---@field isTrigger true Makes portal a 'ghost' to player
---@field hasJustTeleported boolean Avoids getting player stuck on portal
---@field otherPortal Portal Cache for the target portal of this instance
local Portal = {}
Portal.__index = Portal
setmetatable(Portal, prop.Prop)

-- Creates a new portal
---@param x number
---@param y number
---@param pair integer
---@return Portal instance
function Portal.new(x, y, pair)
    y = y - TileSize
    local instance = prop.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='placeholder' })
    setmetatable(instance, Portal)
    ---@cast instance Portal
    instance.pair = pair
    instance.isTrigger = true
    instance.hasJustTeleported = false
    return instance
end

-- Updates portal and teleports player if being touched
---@param player Player Player instance
function Portal:update(_, player)
    -- Gets the pair of this portal and caches it
    if not self.otherPortal then
        for _, p in ipairs(prop.propList) do
            if getmetatable(p) == Portal and p.pair == self.pair and p ~= self then
                self.otherPortal = p
                break
            end
        end
    end

    -- Avoids crashes
    if not self.otherPortal then return end

    -- Checks if player is touching the portal
    local _, _, cols, len = World:check(self, self.x, self.y)
    local touchingPlayer = false
    for i = 1, len do
        if cols[i].other == player then
            touchingPlayer = true
        end
    end

    if touchingPlayer then 
        -- If not just teleported, teleports
        if not self.hasJustTeleported and not self.otherPortal.hasJustTeleported then
            -- Moves player through both physical and logical world
            player.x = self.otherPortal.x
            player.y = self.otherPortal.y
            World:update(player, player.x, player.y, player.width, player.height)

            -- Avoids going back and forth (stuck)
            self.hasJustTeleported = true
            self.otherPortal.hasJustTeleported = true
        end
    else
        -- Resets this portal if player is not touching
        self.hasJustTeleported = false
    end
end

return Portal