# frozen_string_literal: true

module Text
  def instructions_text
    <<~HEREDOC

    === WELCOME TO CONNECT FOUR ===

    A text-based game four two humans.

    How to play:

    When prompted, enter a column number
    to place your counter!

    HEREDOC
  end

  def winner_text(number)
    "\n\n\e[32mPlayer #{number} wins! Great job!\e[0m\n\n"
  end

  def draw_text
    "\n\nIt's a draw this time!\n\n"
  end

  def player_input_prompt_text(num)
    "\nEnter your selection, Player #{num}:"
  end

  def input_error_text
    "\e[31mInvalid input, try again!\e[0m"
  end
end
