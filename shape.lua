local shapes = require 'shapes'

return function()
  local shape = shapes[1]
  local orientation = 1
  local left = 0
  local top = 0

  local function blocks()
    return shape[orientation]
  end

  local function each_block(fn)
    for row_index, row in ipairs(blocks()) do
      for column_index, column in ipairs(row) do
        if column == 1 then
          local x = column_index + left
          local y = row_index + top
          fn(x, y)
        end
      end
    end
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
    left = left + (move_left and -1 or 1)
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
