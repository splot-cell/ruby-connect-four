# frozen_string_literal: true

class Board
  def initialize(grid = Array.new(7, Array.new(6)))
    @grid = grid
  end

  def insert(item, col)
    @grid[col][0] = item
  end
end
