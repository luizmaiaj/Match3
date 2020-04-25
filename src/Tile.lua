--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

Tile = Class{__includes = Particles}

function Tile:init(x, y, color, variety, level)
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * 32
    self.y = (self.gridY - 1) * 32

    -- tile appearance/points
    self.color = color
    self.variety = variety
    local max = 64 / level >= 10 and 64 / level or 10 -- maximum one every 10 tiles to become shiny
    self.shiny = math.random(0, max) == 0 and true or false -- one in 32 chance of being a shiny block

    if self.shiny then
        self:initParticles()
    end
end

function Tile:update(dt)
    if self.shiny then
        self:hitParticles(1, 1) -- don't vary color for now
        self:updateParticles(dt)
    end
end

function Tile:render(x, y)
    
    -- draw shadow
    love.graphics.setColor(34/255, 32/255, 52/255, 255/255)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety], self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety], self.x + x, self.y + y)
end

function Tile:drawTile(x, y)
    if self.shiny then
        self:draw(x, y)
    end
end