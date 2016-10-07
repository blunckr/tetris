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
      if x < 1 or x > #board[1] then
        valid = false
      end
    end, shape_params)
    return valid
  end

  local function rotate(reverse)
    orientation = orientation + (reverse and -1 or 1)
    if orientation > 4 then
      orientation = 1
    elseif orientation < 1 then
      orientation = 4
    end
  end

  local function move_x(move_left)
    local next_left = left + (move_left and -1 or 1)
    if next_position_valid{left=next_left} then
      left = next_left
    end
  end

  local function drop()
    top = top + 1
  end

  return {
    each_block = each_block,
    rotate = rotate,
    move_x = move_x,
    drop = drop,
  }
end
