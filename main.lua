local Game = require 'game'
local game = Game.new()

function love.load()
  love.window.setMode(400, 520)
end

love.keyboard.setKeyRepeat(true)

function love.keypressed(key)
  game:keypressed(key)
end

function love.update(dt)
  game:update(dt)
end

function love.draw()
  game:draw()
end
