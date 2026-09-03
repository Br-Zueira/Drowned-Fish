local props = require 'modules.props'
local voicelines = require 'modules.voicelines'

-- Cursor idea: Cursor that brings saw while player is at the gap, then a portal reveals itself right at the last second

-- Custom, single level data
local data = {}

function data.whenLoaded()
    voicelines.add('oopsie', 2)
    voicelines.add('cmon', 4)
    voicelines.add('loser', 6)
    voicelines.add('cmon', 6, 1, 4, true)
    voicelines.add('oopsie', 6, 1, 4, true)
end

local cursor = {}

function data.whenReloaded(player)
    cursor = {}
end

function data.update(dt, player) end

local levelTrigger = {}
levelTrigger.__index = levelTrigger
setmetatable(levelTrigger, props.Trigger)

function levelTrigger:update(_, player)
    if not props.isPlayerInRadius(self, player, self.radius) then return end
    self:delete()
    if self.id == 'spawnCursor' then
        -- Moves cursor to spring location
        cursor:goto({x=TileSize*8.5, y=cursor.y}, { isFixedTime=true, time=0.2 })

        -- Custom saw that follows cursor
        local followSaw = props.Saw.new(cursor.x, cursor.y)
        function followSaw:update(dt)
            -- Standard saw behavior (rotating)
            props.Saw.update(self, dt)

            -- Avoids crashing
            if not World:hasItem(self) then return end
            self.x, self.y = World:move(
                self,
                cursor.x - TileSize/2, -- Cursor pos + arbitrary offset
                cursor.y - TileSize/2,
                function () return nil end -- Ignores all collisions
            )

            -- Makes it so the saw no longer follows cursor after it reaching its goal
            -- And resets the saw behavior to standard saw behavior
            if not cursor.goal then self.update = props.Saw.update end
        end
    end
end

function data.ObjHandler(obj)
    local p = obj.properties
    if obj.name == "Trigger" then
        local t = props.Trigger.new(obj.x, obj.y, p.id, p.radius)
        setmetatable(t, levelTrigger)
    elseif obj.name == "Cursor" then
        cursor = props.Cursor.new(obj.x, obj.y)
    end
end

function data.MiscHandler(map) end

return data