# frozen_string_literal: true

class Board
  def initialize(grid = Array.new(7, Array.new(6)))
    @grid = grid
  end

  def insert(item, col)
    @grid[col][empty_row(col)] = item
  end

  def empty_row(col)
    @grid[col].find_index(nil)
  end
end
