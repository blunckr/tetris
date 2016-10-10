local Board = {}
Board.__index = Board

function Board.new()
  local self = setmetatable({}, Board)

  self.width = 10
  self.height = 16
  self.grid = {}
  for row = 1, self.height do
    self.grid[row] = {}
    for column = 1, self.width do
      self.grid[row][column] = 0
    end
  end

  return self
end

function Board.block_is_valid(self, x, y)
  return x >= 1 and
    x <= self.width and
    y <= self.height and
    self.grid[y][x] == 0
end

function Board.eat(self, x, y)
  self.grid[y][x] = 1
end

function Board.draw_boundaries(self)
  love.graphics.rectangle(
    'line',
    9,
    9,
    self.width * 10,
    self.height * 10)
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
