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
      # NOTE: in this representation, the columns and rows are swapped visually, as the grid is accessed by [x][y]
      let(:grid_non_empty) do
        [[nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         ["A", "B", nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil]]
      end
      subject(:board_not_empty) { described_class.new(grid_non_empty) }

      it "adds item to the lowest empty row in the columm" do
        item = "C"
        col = 4
        expect { board_not_empty.insert(item, col) }.to change { board_not_empty.instance_variable_get(:@grid)[col][2] }.from(nil).to(item)
      end
    end
  end

  describe "#empty_row" do
    context "when the column is empty" do
      it "returns 0" do
        expect(board_init.empty_row(4)).to be_zero
      end

      it "returns 0" do
        expect(board_init.empty_row(6)).to be_zero
      end
    end

    context "when the column has one item taken" do
      let(:grid_one_full_row) do
        [["A", nil, nil, nil, nil, nil],
         ["B", nil, nil, nil, nil, nil],
         ["C", nil, nil, nil, nil, nil],
         ["D", nil, nil, nil, nil, nil],
         ["E", nil, nil, nil, nil, nil],
         ["F", nil, nil, nil, nil, nil],
         ["G", nil, nil, nil, nil, nil]]
      end
      subject(:board_one_row) { described_class.new(grid_one_full_row) }

      it "returns 1" do
        expect(board_one_row.empty_row(0)).to eq(1)
      end

      it "returns 1" do
        expect(board_one_row.empty_row(5)).to eq(1)
      end
    end

    context "when the column has more than one item taken" do
      let(:grid_half_full) do
        [["A", "T", nil, nil, nil, nil],
         ["B", "A", "G", nil, nil, nil],
         ["C", "O", "W", "S", nil, nil],
         ["D", "A", "V", "I", "D", nil],
         ["E", "G", "G", nil, nil, nil],
         ["F", "I", "N", "D", nil, nil],
         ["G", "O", nil, nil, nil, nil]]
      end
      subject(:board_half_full) { described_class.new(grid_half_full) }

      context "when column has 2 rows taken" do
        it "returns 2" do
          expect(board_half_full.empty_row(0)).to eq(2)
        end
      end

      context "when column has 5 rows taken" do
        it "returns 5" do
          expect(board_half_full.empty_row(3)).to eq(5)
        end
      end
    end
  end
end
