local Shape = {}
Shape.__index = Shape

function Shape.new(shape)
  local self = setmetatable({}, Shape)
  self.shape = shape
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

function Shape.rotate(self, direction, validate)
  local next_orientation = self.orientation +
    (direction == 'reverse' and -1 or 1)
  if next_orientation > 4 then
    next_orientation = 1
  elseif next_orientation < 1 then
    next_orientation = 4
  end
  if validate(self:blocks{orientation=next_orientation}) then
    self.orientation = next_orientation
  end
end

function Shape.move_x(self, direction, validate)
  local next_left = self.left + (direction == 'left' and -1 or 1)
  if validate(self:blocks{left=next_left}) then
    self.left = next_left
  end
end

function Shape.drop(self, validate)
  local next_top = self.top + 1
  if validate(self:blocks{top=next_top}) then
    self.top = next_top
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
