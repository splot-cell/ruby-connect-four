# frozen_string_literal: true

require_relative "board"

class ConnectFour
  def initialize(board = Board.new)
    @board = board
    @player_one = { num: 1, counter: "\u26aa".encode("utf-8") }
    @player_two = { num: 2, counter: "\u26ab".encode("utf-8") }
    @current_player = @player_one
  end

  def play
    instructions
    loop do
      return draw if @board.full?

      play_turn
      break if @board.game_over?

      toggle_current_player
    end
    winner(@current_player)
  end

  def instructions
  end

  def draw
  end

  def play_turn
  end

  def toggle_current_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def winner(change_me)
  end

  def validate_input(selection)
    selection >= 0 && selection < @board.num_cols && !@board.column_full?(selection)
  end
end
