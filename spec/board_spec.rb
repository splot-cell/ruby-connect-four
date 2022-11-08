# frozen_string_literal: true

require_relative "../lib/board"

describe Board do
  subject(:board_init) { described_class.new }

  describe "#empty_row" do
    context "when the column is empty" do
      it "returns index of last row" do
        expect(board_init.empty_row(4)).to eq(5)
      end

      it "returns index of last row" do
        expect(board_init.empty_row(6)).to eq(5)
      end
    end

    context "when the column has one item taken" do
      let(:grid_one_full_row) do
        [[nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         ["A", "B", "C", "D", "E", "F", "G"]]
      end
      subject(:board_one_row) { described_class.new(grid_one_full_row) }

      it "returns index of second-last row" do
        expect(board_one_row.empty_row(0)).to eq(4)
      end

      it "returns index of second-last row" do
        expect(board_one_row.empty_row(5)).to eq(4)
      end
    end

    context "when the column has more than one item taken" do
      let(:grid_half_full) do
        [[nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, "D", nil, nil, nil],
         [nil, nil, "S", "I", nil, "D", nil],
         [nil, "G", "W", "V", "G", "N", nil],
         ["T", "A", "O", "A", "G", "I", "O"],
         ["A", "B", "C", "D", "E", "F", "G"]]
      end
      subject(:board_half_full) { described_class.new(grid_half_full) }

      context "when column has 2 rows taken" do
        it "returns index of third-last row" do
          expect(board_half_full.empty_row(0)).to eq(3)
        end
      end

      context "when column has 5 rows taken" do
        it "returns index of sixth-last row" do
          expect(board_half_full.empty_row(3)).to eq(0)
        end
      end
    end
  end

  describe "#column_full?" do
    let(:grid_full_col) do
      [["S", nil, nil, nil, nil, nil, nil],
       ["C", nil, nil, "D", nil, nil, nil],
       ["I", nil, "S", "I", nil, "D", nil],
       ["T", "G", "W", "V", "G", "N", nil],
       ["T", "A", "O", "A", "G", "I", "O"],
       ["A", "B", "C", "D", "E", "F", "G"]]
    end
    subject(:board_full_col) { described_class.new(grid_full_col) }

    context "when the queried column is full" do
      it "returns true" do
        col = 0
        expect(board_full_col.column_full?(col)).to be true
      end
    end

    context "when the quiered column is not full" do
      it "returns false" do
        col = 5
        expect(board_full_col.column_full?(col)).to be false
      end
    end
  end

  describe "#insert" do
    context "when a column is empty" do
      it "adds an item to the lowest row on the column" do
        item = "X"
        col = 4
        expect { board_init.insert(item, col) }.to change { board_init.instance_variable_get(:@grid)[5][col] }.from(nil).to(item)
      end
    end

    context "when a column is not empty" do
      let(:grid_non_empty) do
        [[nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, nil, nil, nil],
         [nil, nil, nil, nil, "B", nil, nil],
         [nil, nil, nil, nil, "A", nil, nil]]
      end
      subject(:board_not_empty) { described_class.new(grid_non_empty) }

      it "adds item to the lowest empty row in the columm" do
        item = "C"
        col = 4
        expect { board_not_empty.insert(item, col) }.to change { board_not_empty.instance_variable_get(:@grid)[3][col] }.from(nil).to(item)
      end
    end
  end
end
