-- 16 rows
-- 10 columns
local shapes = require('shapes')
local current_shape = shapes[1]
local orientation = 1

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
  end
end

function love.draw()
  for row_index, row in ipairs(current_shape[orientation]) do
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
