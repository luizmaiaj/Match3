--[[
    -- Particles Class --

    Author: Luiz Maia
]]

Particles = Class{}

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
    self.psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0)
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