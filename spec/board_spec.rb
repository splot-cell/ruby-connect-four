# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  subject(:board_init) { described_class.new }

  describe "#insert" do
    context "when a column is empty" do
      it "adds an item to the lowest row on the column" do
        item = "X"
        expect { board_init.insert(4) }.to change { board_init.grid[4][0] }.from(nil).to(item)
      end
    end
  end
end
