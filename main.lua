local shapes = require 'shapes'

local current_shape = shapes[1]
local orientation = 1
local board = {}
local drop_timer = 0
local top = 0
local left = 0

for row = 1, 16 do
  board[row] = {}
  for column = 1, 10 do
    board[row][column] = 0
  end
end

function love.load()
  love.window.setMode(400, 520)
end

local function rotate_shape()
  orientation = orientation + 1
  if orientation > 4 then
    orientation = 1
  elseif orientation < 0 then
    orientation = 4
  end
end

love.keyboard.setKeyRepeat(true)

function love.keypressed(key)
  if key == 'up' then
    rotate_shape()
  elseif key == 'down' then
    rotate_shape(true)
  elseif key == 'left' then
    left = left - 1
  elseif key == 'right' then
    left = left + 1
  end
end

function love.update(dt)
  drop_timer = drop_timer + dt
  if drop_timer > .5 then
    top = top + 1
    drop_timer = 0
  end
end

local function each_shape_block(fn)
  for row_index, row in ipairs(current_shape[orientation]) do
    for column_index, column in ipairs(row) do
      if column == 1 then
        local x = column_index + left
        local y = row_index + top
        fn(x, y)
      end
    end
  end
end

local function draw_current_shape()
  each_shape_block(function(x, y)
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
