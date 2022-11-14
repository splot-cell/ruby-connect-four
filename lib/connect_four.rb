# frozen_string_literal: true

require_relative "board"
require_relative "text"

class ConnectFour
  include Text

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

  def play_turn
    display_board
    column = player_input
    @board.insert(@current_player[:counter], column)
  end


  def player_input
    player_input_prompt
    selection = nil
    loop do
      selection = gets.chomp
      break if validate_input(selection)
      input_error
    end
    selection.to_i
  end

  def toggle_current_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def validate_input(selection)
    return false unless selection.match(/^[0-9]$/)

    selection.to_i >= 0 && selection.to_i < @board.num_cols && !@board.column_full?(selection.to_i)
  end

  private

  def winner(player)
    display_board
    puts winner_text(player[:num])
  end

  def display_board
    puts @board.to_s
  end

  def input_error
    puts input_error_text
  end

  def player_input_prompt
    print player_input_prompt_text(@current_player[:num])
  end

  def instructions
    puts instructions_text
  end

  def draw
    puts draw_text
  end
end
