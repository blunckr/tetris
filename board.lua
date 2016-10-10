local Board = {}
Board.__index = Board

function Board.new()
  local self = setmetatable({}, Board)
  self.width = 10
  self.height = 16
  self.grid = {}
  self:generate_empty_rows()
 return self
end

function Board.generate_empty_rows(self)
  while #self.grid < self.height do
    table.insert(self.grid, 1, {})
    for column = 1, self.width do
      self.grid[1][column] = 0
    end
  end
end

function Board.shape_is_valid(self, shape)
  for _, block in ipairs(shape) do
    if block.x < 1 or
      block.x > self.width or
      block.y > self.height or
      self.grid[block.y][block.x] == 1
    then
      return false
    end
  end
  return true
 end

function Board.eat_blocks(self, blocks)
  for _, block in ipairs(blocks) do
    self.grid[block.y][block.x] = 1
  end
end

function Board.draw_boundaries(self)
  love.graphics.rectangle(
    'line',
    9,
    9,
    self.width * 10,
    self.height * 10)
end

local function row_is_complete(row)
  for _, column in ipairs(row) do
    if column == 0 then
      return false
    end
  end
  return true
end

function Board.check_complete_rows(self)
  local complete_rows = {}
  -- we want the list in reverse so things don't get messed up when removing
  for row_index = #self.grid, 1, -1 do
    local row = self.grid[row_index]
    if row_is_complete(row) then
      complete_rows[#complete_rows+1] = row_index
    end
  end

  for _, row_index in ipairs(complete_rows) do
    table.remove(self.grid, row_index)
  end

  self:generate_empty_rows()
end

function Board.draw_grid(self)
  for row_index, row in ipairs(self.grid) do
    for column_index, column in ipairs(row) do
      if column == 1 then
        love.graphics.rectangle(
          'fill',
          column_index * 10,
          row_index * 10,
          9,
          9)
      end
    end
  end
end

function Board.draw(self)
  self:draw_boundaries()
  self:draw_grid()
end

return Board
