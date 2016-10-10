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
  self.shape = Shape.new(self.board)
end

function Game.keypressed(self, key)
  if key == 'up' then
    self.shape:rotate()
  elseif key == 'down' then
    self.shape:rotate(true)
  elseif key == 'left' then
    self.shape:move_x(true)
  elseif key == 'right' then
    self.shape:move_x()
  end
end

function Game.update(self, dt)
  self.drop_timer = self.drop_timer + dt
  if self.drop_timer > .5 then
    self.shape:drop()
    self.drop_timer = 0
  end
end

function Game.draw(self)
  self.board:draw()
  self.shape:draw()
end

return Game
