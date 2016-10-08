local Shape = require 'shape'
local Board = require 'board'

local board = Board.new()
local drop_timer = 0

local shape = Shape.new(board)

function love.load()
  love.window.setMode(400, 520)
end

love.keyboard.setKeyRepeat(true)

function love.keypressed(key)
  if key == 'up' then
    shape:rotate()
  elseif key == 'down' then
    shape:rotate(true)
  elseif key == 'left' then
    shape:move_x(true)
  elseif key == 'right' then
    shape:move_x()
  end
end

function love.update(dt)
  drop_timer = drop_timer + dt
  if drop_timer > .5 then
    shape:drop()
    drop_timer = 0
  end
end

function love.draw()
  board:draw()
  shape:draw()
end
