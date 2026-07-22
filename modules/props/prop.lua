-- Wrapper to export everything
local props = {}

-- Stores all props in the world (logic world)
props.propList = {}

-- Prop parent metatable
---@class Prop
---@field x number X position of prop
---@field y number Y position of prop
---@field sizeX number Width of prop
---@field sizeY number Heigth of prop
---@field renderTable table -- Can be either {false, r, g, b, a}, {true, imgName} or {nil}
props.Prop = {}
props.Prop.__index = props.Prop

-- Creates a generic prop
---@param x number X position of prop
---@param y number Y position of prop
---@param sizeX number Width of prop
---@param sizeY number Heigth of prop
---@param renderTable table -- Can be either {false, r, g, b, a}, {true, imgName} or {nil}
function props.Prop.new(x, y, sizeX, sizeY, renderTable)
    renderTable = renderTable or { isImg=false, rgba={1, 1, 1, 1} }

    -- Creates instance
    local instance = { x=x, y=y, sizeX=sizeX, sizeY=sizeY, renderTable=renderTable }

    -- Binds instance to props metatable
    setmetatable(instance, props.Prop)

    -- Adds instance to physics world
    World:add(instance, x, y, sizeX, sizeY)

    -- Inserts instance into propList
    table.insert(props.propList, instance)
    return instance
end

-- Deletes a prop, both from physics world and from propList (logic world)
function props.Prop:delete()
    -- Remove prop from physics
    if World:hasItem(self) then World:remove(self) end

    -- Remove prop form prop list
    for i, p in ipairs(props.propList) do
        if p == self then 
            table.remove(props.propList, i)
            return
        end
    end
end

-- Checks if player is closer from prop than given radius
---@param prop Prop 
---@param player Player
---@param radius integer
function props.isPlayerInRadius(prop, player, radius)
    -- Find center point of player
    local px = player.x + (player.width / 2)
    local py = player.y + (player.height / 2)

    -- Find center point of prop
    local tx = prop.x + (prop.sizeX / 2)
    local ty = prop.y + (prop.sizeY / 2)

    -- Vector distance between centers
    local dx = px - tx
    local dy = py - ty

    -- Circular radius check using squared distance to reduce performance cost
    return (dx * dx + dy * dy) <= (radius * radius)
end

-- Returns props to every module that imports this one
return props