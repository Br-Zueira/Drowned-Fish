local p = 'modules.props.'

local props = require(p .. 'prop')
props.Tile = require(p .. 'tile')
props.Spike = require(p .. 'spike')
props.Goal = require(p .. 'goal')
props.Saw = require(p .. 'saw')
props.MoverSaw = require(p .. 'moverSaw')

return props