--[[
    -- Particles Class --

    Author: Luiz Maia
]]

Particles = Class{}

paletteColors = {
    [1] = { ['r'] = 217/255, ['g'] = 160/255, ['b'] = 102/255 },
    [2] = { ['r'] = 138/255, ['g'] = 111/255, ['b'] = 48/255 },
    [3] = { ['r'] = 82/255, ['g'] = 75/255, ['b'] = 36/255 },
    [4] = { ['r'] = 75/255, ['g'] = 105/255, ['b'] = 47/255 },
    [5] = { ['r'] = 55/255, ['g'] = 148/255, ['b'] = 110/255 },
    [6] = { ['r'] = 91/255, ['g'] = 110/255, ['b'] = 225/255 },
    [7] = { ['r'] = 48/255, ['g'] = 96/255, ['b'] = 130/255 },
    [8] = { ['r'] = 63/255, ['g'] = 63/255, ['b'] = 116/255 }}

function Particles:initParticles()
    -- particle system belonging to the brick, emitted on hit
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'], 10)

    self.width = gTextures['particle']:getWidth()
    self.height = gTextures['particle']:getHeight()

    -- various behavior-determining functions for the particle system
    -- https://love2d.org/wiki/ParticleSystem

    -- lasts between 0.5-1 seconds seconds
    self.psystem:setParticleLifetime(0.5, 1)

    -- give it an acceleration of anywhere between X1,Y1 and X2,Y2 (0, 0) and (80, 80) here
    -- gives generally downward 
    -- just make explode in all directions
    self.psystem:setLinearAcceleration(-5, -5, 5, 5)

    -- spread of particles; normal looks more natural than uniform
    self.psystem:setEmissionArea('normal', 2, 2) -- normal means normal distribution like a gaussian
end

--[[
    Triggers a hit on the brick, taking it out of play if at 0 health or
    changing its color otherwise.
]]
function Particles:hitParticles(tier, color)
    -- set the particle system to interpolate between two colors; in this case, we give
    -- it our self.color but with varying alpha; brighter for higher tiers, fading to 0
    -- over the particle's lifetime (the second color)
    self.psystem:setColors(
        paletteColors[color].r,
        paletteColors[color].g,
        paletteColors[color].b,
        1,
        paletteColors[color].r,
        paletteColors[color].g,
        paletteColors[color].b,
        0)
        
    self.psystem:emit(5)
end

function Particles:updateParticles(dt)
    self.psystem:update(dt)
end

--[[
    Need a separate render function for our particles so it can be called after all bricks are drawn;
    otherwise, some bricks would render over other bricks' particle systems.
]]
function Particles:draw(x, y)
    love.graphics.draw(self.psystem, self.x + x + 16, self.y + y + 16)
end