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

  def play_turn
    display_board
    column = player_input
    @board.insert(@current_player[:counter], column)
  end


  def player_input
    player_input_prompt
    selection = nil
    loop do
      selection = gets.chomp.to_i
      break if validate_input(selection)
      input_error
    end
    selection
  end

  def toggle_current_player
    @current_player = @current_player == @player_one ? @player_two : @player_one
  end

  def validate_input(selection)
    selection >= 0 && selection < @board.num_cols && !@board.column_full?(selection)
  end

  private

  def winner(player)
    puts "Player #{player[:num]} wins!"
  end

  def display_board
    puts @board.to_s
  end

  def input_error
    puts "Input error"
  end

  def player_input_prompt
    puts "Enter a selection, Player #{@current_player[:num]}:"
  end

  def instructions
    puts "Instructions here"
  end

  def draw
    puts "It's a draw!"
  end
end
