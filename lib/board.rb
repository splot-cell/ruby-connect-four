# frozen_string_literal: true

class Board
  def initialize(grid = Array.new(6, Array.new(7)))
    @grid = grid
  end

  def insert(item, col)
    @grid[empty_row(col)][col] = item
  end

  def empty_row(col)
    @grid.length - @grid.transpose[col].reverse.find_index(nil) - 1
  end
end
