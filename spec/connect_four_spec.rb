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
      end
    end
  end

end
