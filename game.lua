local Board = require 'board'
local Shape = require 'shape'

local Game = {}
Game.__index = Game

function Game.new()
  local self = setmetatable({}, Game)
  self.board = Board.new()
  self.drop_timer = 0
  self:new_shape()
  return self
end

function Game.new_shape(self)
  self.shape = Shape.new()
end

function Game.drop_shape(self)
  local valid
  self.shape:drop(function(next_shape)
    valid = self.board:shape_is_valid(next_shape)
    if not valid then
      self.board:eat_blocks(self.shape:blocks())
      self:new_shape()
    end
    return valid
  end)
  return valid
end

function Game.quick_drop(self)
  local settled = false
  while settled == false do
    settled = not self:drop_shape()
  end
end

function Game.keypressed(self, key)
  local validate = function(next_shape)
    return self.board:shape_is_valid(next_shape)
  end
  if key == 'up' then
    self.shape:rotate('forward', validate)
  elseif key == 'down' then
    self.shape:rotate('reverse', validate)
  elseif key == 'left' then
    self.shape:move_x('left', validate)
  elseif key == 'right' then
    self.shape:move_x('right', validate)
  elseif key == 'space' then
    self:quick_drop()
  end
end

function Game.update(self, dt)
  self.drop_timer = self.drop_timer + dt
  if self.drop_timer > .5 then
    self.drop_timer = 0
    self:drop_shape()
  end
end

function Game.draw(self)
  self.board:draw()
  self.shape:draw()
end

return Game
