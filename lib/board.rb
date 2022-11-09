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
  TARGET_LENGTH = 4
  def game_over?
    @grid.each_index do |row_index|
      @grid[row_index].each_index do |col_index|
        DIRECTIONS.each do |dir|
          return true if connected_line_length(row_index, col_index, dir) >= TARGET_LENGTH
        end
      end
    end
    false
  end

  def connected_line_length(row_index, col_index, direction_vector)
    value = @grid[row_index][col_index]
    r = row_index + direction_vector[0]
    c = col_index + direction_vector[1]
    line_length = 1
    while within_bounds?(r, c) && value && @grid[r][c] == value
      line_length += 1
      r += direction_vector[0]
      c += direction_vector[1]
    end
    line_length
  end
end
