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

  def column_full?(col)
    !@grid[0][col].nil?
  end

  def within_bounds?(row, col)
    row.between?(0, @grid.length - 1) && col.between?(0, @grid[0].length - 1)
  end

  DIRECTIONS = [[1, 0], [0, 1], [1, 1], [1, -1]].freeze
  def game_over?
    target_length = 4
    @grid.each_index do |row|
      @grid[row].each_index do |col|
        value = @grid[row][col]
        r = row + DIRECTIONS[0][0]
        c = col + DIRECTIONS[0][1]
        line_length = 1
        while within_bounds?(r, c) && value && @grid[r][c] == value
          line_length += 1
          return true if line_length >= target_length

          r += DIRECTIONS[0][0]
          c += DIRECTIONS[0][1]
        end
      end
    end
    false
  end
end
