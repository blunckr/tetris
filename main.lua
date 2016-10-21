local Game = require 'game'

local high_score = 0
local game
local paused = false

local function update_score(new_score)
  high_score = new_score
end

local function new_game()
  game = Game.new(update_score)
end

function love.load()
  love.window.setMode(400, 520)
  new_game()
end

love.keyboard.setKeyRepeat(true)

function love.keypressed(key)
  if key == 'p' then
    paused = not paused
  end
  if not paused then
    game:keypressed(key)
  end
end

function love.update(dt)
  if not paused then
    game:update(dt)
  end
end

function love.draw()
  game:draw()
end
