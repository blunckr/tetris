local Shape = require 'shape'

local board = {}
local drop_timer = 0

for row = 1, 16 do
  board[row] = {}
  for column = 1, 10 do
    board[row][column] = 0
  end
end

local shape = Shape(board)

function love.load()
  love.window.setMode(400, 520)
end

love.keyboard.setKeyRepeat(true)

function love.keypressed(key)
  if key == 'up' then
    shape.rotate()
  elseif key == 'down' then
    shape.rotate(true)
  elseif key == 'left' then
    shape.move_x(true)
  elseif key == 'right' then
    shape.move_x()
  end
end

function love.update(dt)
  drop_timer = drop_timer + dt
  if drop_timer > .5 then
    shape.drop()
    drop_timer = 0
  end
end

local function draw_current_shape()
  shape.each_block(function(x, y)
    love.graphics.rectangle(
      'fill',
      x * 10,
      y * 10,
      9,
      9)
  end)
end

local function draw_boundaries()
  love.graphics.rectangle(
    'line',
    9,
    9,
    100,
    160)
end

local function draw_board()
  for row_index, row in ipairs(board) do
    for column_index, column in ipairs(row) do
      if column == 1 then
        love.graphics.rectangle(
          'fill',
          (column_index - 1) * 10,
          (row_index - 1) * 10,
          9,
          9)
      end
    end
  end
end

function love.draw()
  draw_boundaries()
  draw_current_shape()
  draw_board()
end
