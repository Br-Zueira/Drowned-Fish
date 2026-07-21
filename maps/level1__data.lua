local props = require 'modules.props'
local assets = require 'modules.assets'

-- Custom, single level data
local data = {}

function data.whenLoaded()
    love.audio.play(assets.audio.intro)
end

function data.whenReloaded(player)
    local d = player.levelDeaths
    if d == 1 then
        love.audio.play(assets.audio.oopsie)
    elseif d == 2 then
        love.audio.play(assets.audio.cmon)
    elseif d == 3 then
        love.audio.play(assets.audio.loser)
    else
        local odd = math.random(1, 4)
        if odd == 1 then
            love.audio.play(assets.audio.oopsie)
        elseif odd == 2 then
            love.audio.play(assets.audio.cmon)
        end
    end
end

-- Fake goal that moves when player is close
data.FakeGoal = {}
data.FakeGoal.__index = data.FakeGoal
setmetatable(data.FakeGoal, props.Prop)

function data.FakeGoal.new(x, y, newX, newY, radius)
    y = y - TileSize
    local instance = props.Prop.new(x, y, TileSize, TileSize, { isImg=true, imgName='goal' })
    instance.newX = newX
    instance.newY = newY
    instance.radius = radius
    setmetatable(instance, data.FakeGoal)
    return instance
end

function data.FakeGoal:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        props.Goal.new(self.newX, self.newY)
        self:delete()
    end
end

data.InviSpike = {}
data.InviSpike.__index = data.InviSpike
setmetatable(data.InviSpike, props.Prop)

function data.InviSpike.new(x, y, radius)
    y = y - TileSize/2
    local instance = props.Prop.new(x, y, TileSize, TileSize/2, { isImg=nil })
    instance.radius = radius
    setmetatable(instance, data.InviSpike)
    return instance
end

function data.InviSpike:update(_, player)
    if props.isPlayerInRadius(self, player, self.radius) then
        self:delete()
        props.Spike.new(self.x, self.y+TileSize/2)
    end
end

-- O is object
function data.handler(o)
    local n = o.name
    local p = o.properties
    if n == 'FakeGoal' then
        data.FakeGoal.new(o.x, o.y, p.newX, p.newY, p.radius)
    elseif n == 'InviSpike' then
        data.InviSpike.new(o.x, o.y, p.radius)
    end
end
return data