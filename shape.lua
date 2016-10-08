local shapes = require 'shapes'

local Shape = {}
Shape.__index = Shape

function Shape.new(board)
  local self = setmetatable({}, Shape)

  self.board = board
  self.shape = shapes[1]
  self.orientation = 1
  self.left = 0
  self.top = 0

  return self
end

local function _blocks(self, orientation, left, top)
  local blocks = {}
  for row_index, row in ipairs(self.shape[orientation]) do
    for column_index, column in ipairs(row) do
      if column == 1 then
        local x = column_index + left
        local y = row_index + top
        blocks[#blocks + 1] = {x=x, y=y}
      end
    end
  end
  return blocks
end

function Shape.blocks(self, shape_params)
  shape_params = shape_params or {}
  return _blocks(
    self,
    shape_params.orientation or self.orientation,
    shape_params.left or self.left,
    shape_params.top or self.top
  )
end

function Shape.next_position_valid(self, shape_params)
  for _, block in ipairs(self:blocks(shape_params)) do
    if
      block.x < 1 or
      block.x > #self.board.grid[1] or
      block.y > #self.board.grid or
      self.board.grid[block.y][block.x] == 1
    then
      return false
    end
  end
  return true
end

function Shape.rotate(self, reverse)
  local next_orientation = self.orientation + (reverse and -1 or 1)
  if next_orientation > 4 then
    next_orientation = 1
  elseif next_orientation < 1 then
    next_orientation = 4
  end
  if self:next_position_valid{orientation=next_orientation} then
    self.orientation = next_orientation
  end
end

function Shape.move_x(self, move_left)
  local next_left = self.left + (move_left and -1 or 1)
  if self:next_position_valid{left=next_left} then
    self.left = next_left
  end
end

function Shape.drop(self)
  local next_top = self.top + 1
  if self:next_position_valid{top=next_top} then
    self.top = next_top
  else
    self.board:eat()
  end
end

function Shape.draw(self)
  for _, block in ipairs(self:blocks()) do
    love.graphics.rectangle(
      'fill',
      block.x * 10,
      block.y * 10,
      9,
      9)
  end
end

return Shape
