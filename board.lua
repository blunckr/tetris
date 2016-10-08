return function()

  local grid = {}

  for row = 1, 16 do
    grid[row] = {}
    for column = 1, 10 do
      grid[row][column] = 0
    end
  end

  local function draw_boundaries()
    love.graphics.rectangle(
      'line',
      9,
      9,
      100,
      160)
  end

  local function draw_grid()
    for row_index, row in ipairs(grid) do
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

  local function draw()
    draw_boundaries()
    draw_grid()
  end

  return {
    draw=draw,
    grid=grid
  }
end
