# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  subject(:board_init) { described_class.new }

  describe "#insert" do
    context "when a column is empty" do
      it "adds an item to the lowest row on the column" do
        item = "X"
        col = 4
        expect { board_init.insert(item, col) }.to change { board_init.grid[col][0] }.from(nil).to(item)
      end
    end
  end
end
