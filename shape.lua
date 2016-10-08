local shapes = require 'shapes'

return function(board)
  local shape = shapes[1]
  local orientation = 1
  local left = 0
  local top = 0

  local function _each_block(fn, t_orientation, t_left, t_top)
    for row_index, row in ipairs(shape[t_orientation]) do
      for column_index, column in ipairs(row) do
        if column == 1 then
          local x = column_index + t_left
          local y = row_index + t_top
          fn(x, y)
        end
      end
    end
  end

  local function each_block(fn, shape_params)
    shape_params = shape_params or {}
    _each_block(
      fn,
      shape_params.orientation or orientation,
      shape_params.left or left,
      shape_params.top or top
    )
  end

  local function next_position_valid(shape_params)
    local valid = true
    each_block(function(x, y)
      if
        x < 1 or
        x > #board.grid[1] or
        y > #board.grid or
        board.grid[y][x] == 1
      then
        valid = false
      end
    end, shape_params)
    return valid
  end

  local function rotate(reverse)
    local next_orientation = orientation + (reverse and -1 or 1)
    if next_orientation > 4 then
      next_orientation = 1
    elseif next_orientation < 1 then
      next_orientation = 4
    end
    if next_position_valid{orientation=next_orientation} then
      orientation = next_orientation
    end
  end

  local function move_x(move_left)
    local next_left = left + (move_left and -1 or 1)
    if next_position_valid{left=next_left} then
      left = next_left
    end
  end

  local function drop()
    local next_top = top + 1
    if next_position_valid{top=next_top} then
      top = next_top
    else
      board.eat()
    end
  end

  local function draw()
    each_block(function(x, y)
      love.graphics.rectangle(
        'fill',
        x * 10,
        y * 10,
        9,
        9)
    end)
  end

  return {
    each_block=each_block,
    rotate=rotate,
    move_x=move_x,
    drop=drop,
    draw=draw
  }
end
