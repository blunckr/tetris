local Game = require 'game'

local high_score = 0
local game
local paused
local message
local dead = false

local function update_score(new_score)
  if new_score > high_score then
    high_score = new_score
  end
end

local function die()
  paused = true
  dead = true
  message = 'Press the "any" key to begin'
end

local function new_game()
  game = Game.new(update_score, die)
end

local function pause()
  paused = true
  message = 'Press "p" to resume'
end

local function resume()
  paused = false
  message = ''
  if dead then
    new_game()
    dead = false
  end
end

function love.load()
  love.window.setMode(400, 520)
  die()
  new_game()
end

love.keyboard.setKeyRepeat(true)

function love.keypressed(key)
  if paused then
    resume()
  elseif key == 'p' then
    pause()
  else
    game:keypressed(key)
  end
end

function love.update(dt)
  if not paused then
    game:update(dt)
  end
end

function love.draw()
  game:draw(message, high_score)
end
