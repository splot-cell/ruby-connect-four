# frozen_string_literal: true

require_relative "board"

class ConnectFour
  def initialize(board = Board.new)
    @board = board
    @player_one = {num: 1, counter: "\u26aa".encode("utf-8")}
    @player_two = {num: 2, counter: "\u26ab".encode("utf-8")}
  end

  def validate_input(selection)
    selection >= 0 && selection < @board.num_cols && !@board.column_full?(selection)
  end
end
