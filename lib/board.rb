# frozen_string_literal: true

# Stores the state of the connect-four board
class Board
  attr_reader :num_cols

  def initialize(grid = Array.new(6, Array.new(7)))
    @grid = grid
    @num_cols = grid[0].length
  end

  # Insert item into the column with index col
  def insert(item, col)
    @grid[empty_row(col)][col] = item
  end

  # Return the highest row index that currently contains nil
  def empty_row(col)
    @grid.length - @grid.transpose[col].reverse.find_index(nil) - 1
  end

  # Check if column with index col is filled
  def column_full?(col)
    !@grid[0][col].nil?
  end

  # Check if the cell with index [row][col] is within @grid
  def within_bounds?(row, col)
    row.between?(0, @grid.length - 1) && col.between?(0, @grid[0].length - 1)
  end

  DIRECTIONS = [[1, 0], [0, 1], [1, 1], [1, -1]].freeze
  TARGET_LENGTH = 4

  # Look for a line of like-values within @grid, where the line is equal to or greater in length than TARGET_LENGTH
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

  def full?
    @grid.all?(&:all?)
  end

  def to_s
    str = ""
    @grid.each do |row|
      row.each do |e|
        str += e.nil? ? "   " : e
        str += "|"
      end
      str += "\n"
    end
    str
  end

  private

  # Returns the length of the line of like-values within @grid in a given direction from a given starting cell
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
