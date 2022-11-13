# frozen_string_literal: true

require_relative "../lib/connect_four"

describe ConnectFour do
  let(:board) { double("board", num_cols: 7) }
  subject(:game_init) { described_class.new(board) }

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

end
