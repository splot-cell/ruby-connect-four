# frozen_string_literal: true

require_relative "../lib/connect_four"

describe ConnectFour do
  let(:board) { double("board", num_cols: 7) }
  subject(:game_init) { described_class.new(board) }

  describe "#initialize" do
    it "creates a hash called player_one" do
      player = game_init.instance_variable_get(:@player_one)
      expect(player).to be_a(Hash)
    end

    it "creates a hash called player_two" do
      player = game_init.instance_variable_get(:@player_two)
      expect(player).to be_a(Hash)
    end
  end

  describe "#validate_input" do
    context "when the board has 7 columns" do
      context "when the board is empty" do
        before do
          allow(board).to receive(:column_full?).and_return(false)
        end
        context "when the input is 3" do
          it "returns true" do
            expect(game_init.validate_input(3)).to be true
          end
        end
        context "when the input is 7" do
          it "returns false" do
            expect(game_init.validate_input(7)).to be false
          end

          it "calls @board.num_cols" do
            expect(board).to receive(:num_cols).once
            game_init.validate_input(7)
          end

          it "does not call @board.column_full?" do
            expect(board).not_to receive(:column_full?)
            game_init.validate_input(7)
          end
        end
        context "when the input is 0" do
          it "returns true" do
            expect(game_init.validate_input(0)).to be true
          end

          it "calls @board.column_full? with 0" do
            expect(board).to receive(:column_full?).with(0).once
            game_init.validate_input(0)
          end
        end
      end

      context "when the columns are full" do
        before do
          allow(board). to receive(:column_full?).and_return(true)
        end
        context "when the input is 4" do
          it "returns false" do
            expect(game_init.validate_input(4)).to be false
          end

          it "calls @board.num_cols" do
            expect(board).to receive(:num_cols)
            game_init.validate_input(4)
          end

          it "calls @board.column_full with 4" do
            expect(board).to receive(:column_full?).with(4).once
            game_init.validate_input(4)
          end
        end
      end
    end
  end

  describe "#play" do
    before do
      allow(game_init).to receive(:instructions)
      allow(game_init).to receive(:draw)
      allow(game_init).to receive(:play_turn)
      allow(game_init).to receive(:toggle_current_player)
      allow(game_init).to receive(:winner)
    end

    context "when the game is won this turn" do
      before do
        allow(board).to receive(:full?).and_return(false)
        allow(board).to receive(:game_over?).and_return(true)
      end

      it "calls #play_turn once and stops the loop" do
        expect(game_init).to receive(:play_turn).once
        game_init.play
      end

      it "calls @board.full? once" do
        expect(board).to receive(:full?).once
        game_init.play
      end

      it "does not call #draw" do
        expect(game_init).not_to receive(:draw)
        game_init.play
      end

      it "does not call #toggle_current_player" do
        expect(game_init).not_to receive(:toggle_current_player)
        game_init.play
      end

      it "calls #instructions once" do
        expect(game_init).to receive(:instructions).once
        game_init.play
      end

      it "calls #winner once" do
        expect(game_init).to receive(:winner).once
        game_init.play
      end
    end

    context "when the game is won the following turn" do
      before do
        allow(board).to receive(:full?).and_return(false)
        allow(board).to receive(:game_over?).and_return(false, true)
      end

      it "calls #play_turn twice and stops the loop" do
        expect(game_init).to receive(:play_turn).twice
        game_init.play
      end

      it "calls #instructions once" do
        expect(game_init).to receive(:instructions).once
        game_init.play
      end

      it "calls #toggle_current_player once" do
        expect(game_init).to receive(:toggle_current_player).once
        game_init.play
      end
    end

    context "when @board.game_over? returns false 5 times, then true" do
      before do
        allow(board).to receive(:full?).and_return(false)
        allow(board).to receive(:game_over?).and_return(false, false, false, false, false, true)
      end

      it "calls #play_turn six times and stops the loop" do
        expect(game_init).to receive(:play_turn).exactly(6).times
        game_init.play
      end

      it "calls instructions once" do
        expect(game_init).to receive(:instructions).once
        game_init.play
      end

      it "calls #toggle_current_player five times" do
        expect(game_init).to receive(:toggle_current_player).exactly(5).times
        game_init.play
      end
    end

    context "when @board.full? returns true" do
      before do
        allow(board).to receive(:full?).and_return(true)
      end

      it "calls #draw once" do
        expect(game_init).to receive(:draw).once
        game_init.play
      end

      it "does not call #winner" do
        expect(game_init).not_to receive(:winner)
        game_init.play
      end

      it "does not call #play_turn" do
        expect(game_init).not_to receive(:play_turn)
        game_init.play
      end
    end

    context "when @board.full? returns false once and then true" do
      before do
        allow(board).to receive(:full?).and_return(false, true)
        allow(board).to receive(:game_over?).and_return(false)
      end

      it "calls draw #once" do
        expect(game_init).to receive(:draw).once
        game_init.play
      end

      it "does not call #winner" do
        expect(game_init).not_to receive(:winner)
        game_init.play
      end

      it "does calls #play_turn once" do
        expect(game_init).to receive(:play_turn).once
        game_init.play
      end

      it "calls toggle_current_player once" do
        expect(game_init).to receive(:toggle_current_player).once
        game_init.play
      end
    end
  end

  describe "#toggle_current_player" do
    context "when @current_player is @player_one" do
      it "changes @current_player to @player_two" do
        expect { game_init.toggle_current_player }.to change{ game_init.instance_variable_get(:@current_player) }.from(game_init.instance_variable_get(:@player_one)).to(game_init.instance_variable_get(:@player_two))
      end
    end

    context "when @current_player is @player_two" do
      before do
        game_init.instance_variable_set(:@current_player, game_init.instance_variable_get(:@player_two))
      end

      it "changes @current_player to @player_one" do
        expect { game_init.toggle_current_player }.to change{ game_init.instance_variable_get(:@current_player) }.from(game_init.instance_variable_get(:@player_two)).to(game_init.instance_variable_get(:@player_one))
      end
    end
  end

  describe "#player_input" do
    before do
      allow(game_init).to receive(:player_input_prompt)
    end

    context "when #validate_input returns true" do
      before do
        allow(game_init).to receive(:validate_input).and_return(true)
      end

      it "breaks loop and returns selection" do
        selection = 1
        allow(game_init).to receive(:gets).and_return("1\n")
        expect(game_init.player_input).to eq(selection)
      end
    end

    context "when #validate_input returns false then true" do
      before do
        allow(game_init).to receive(:validate_input).and_return(false, true)
        allow(game_init).to receive(:input_error)
        allow(game_init).to receive(:gets).and_return("2\n")
      end

      it "calls #input_error once" do
        expect(game_init).to receive(:input_error).once
        game_init.player_input
      end

      it "calls #gets twice" do
        expect(game_init).to receive(:gets).twice
        game_init.player_input
      end
    end
  end
end
