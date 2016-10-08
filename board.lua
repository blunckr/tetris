local Board = {}
Board.__index = Board

function Board.new()
  local self = setmetatable({}, Board)

  self.grid = {}
  for row = 1, 16 do
    self.grid[row] = {}
    for column = 1, 10 do
      self.grid[row][column] = 0
    end
  end

  return self
end

function Board.draw_boundaries()
  love.graphics.rectangle(
    'line',
    9,
    9,
    100,
    160)
end

function Board.draw_grid(self)
  for row_index, row in ipairs(self.grid) do
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

function Board.draw(self)
  self:draw_boundaries()
  self:draw_grid()
end

return Board
