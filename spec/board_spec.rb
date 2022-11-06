# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  subject(:board_init) { described_class.new }

  describe "#insert" do
    context "when a column is empty" do
      it "adds an item to the lowest row on the column" do
        item = "X"
        col = 4
        expect { board_init.insert(item, col) }.to change { board_init.instance_variable_get(:@grid)[col][0] }.from(nil).to(item)
      end
    end

    context "when a column is not empty" do
      subject(:board_not_empty) { described_class.new }

      it "adds an item to the lowest empty row in the columm" do
        item = "Y"

      end
    end
  end
end
