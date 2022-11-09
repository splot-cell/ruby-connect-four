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

  describe "#within_bounds?" do
    context "when row is 5 and column is 6" do
      it "returns true" do
        row = 5
        col = 6
        expect(board_init.within_bounds?(row, col)).to be true
      end
    end

    context "when the row is 6 and column is 6" do
      it "returns false" do
        row = 6
        col = 6
        expect(board_init.within_bounds?(row, col)).to be false
      end
    end

    context "when the row is 5 and column is 7" do
      it "returns false" do
        row = 5
        col = 7
        expect(board_init.within_bounds?(row, col)).to be false
      end
    end

    context "when the row is -1 and column is 5" do
      it "returns false" do
        row = -1
        col = 5
        expect(board_init.within_bounds?(row, col)).to be false
      end
    end

    context "when the row is 1 and the column is -5" do
      it "returns false" do
        row = 1
        col = -5
        expect(board_init.within_bounds?(row, col)).to be false
      end
    end
  end

  describe "#game_over?" do
    context "when a line of four equal elements is made" do
      context "when the line is vertical" do
        let(:grid_vert_win) do
          [[nil, "S", "I", nil, nil, nil, nil],
           [nil, "W", "I", nil, "G", nil, nil],
           [nil, "I", "I", nil, "G", nil, nil],
           ["T", "G", "W", "V", "G", "N", nil],
           ["T", "A", "O", "A", "G", "I", "I"],
           ["A", "B", "C", "D", "E", "F", "H"]]
        end
        subject(:board_vert) { described_class.new(grid_vert_win) }
        it "returns true" do
          expect(board_vert).to be_game_over
        end
      end
      context "when the line is horizontal" do
        let(:grid_hori_win) do
          [[nil, "S", "I", nil, nil, nil, nil],
           [nil, "W", "I", nil, "G", nil, nil],
           [nil, "I", "I", "I", "I", nil, nil],
           ["T", "G", "W", "V", "G", "N", nil],
           ["T", "A", "O", "A", "G", "I", "I"],
           ["A", "B", "C", "D", "E", "F", "H"]]
        end
        subject(:board_hori) { described_class.new(grid_hori_win) }
        it "returns true" do
          expect(board_hori).to be_game_over
        end
      end
      context "when the line is diagonal" do
        let(:grid_diag_win) do
          [[nil, "S", "I", nil, nil, nil, nil],
           [nil, "W", "I", nil, "G", nil, nil],
           [nil, "I", "I", "I", "G", nil, nil],
           ["T", "G", "W", "V", "I", "N", nil],
           ["T", "A", "O", "A", "G", "I", "I"],
           ["A", "B", "C", "D", "E", "F", "H"]]
        end
        subject(:board_diag) { described_class.new(grid_diag_win) }
        it "returns true" do
          expect(board_diag).to be_game_over
        end
      end
      context "when the line is anti-diagonal" do
        let(:grid_anti_diag_win) do
          [[nil, "S", "I", nil, nil, nil, nil],
           [nil, "W", "I", nil, "G", nil, nil],
           [nil, "I", "I", "A", "G", nil, nil],
           ["T", "G", "A", "V", "I", "N", nil],
           ["T", "A", "O", "A", "G", "I", "I"],
           ["A", "B", "C", "D", "E", "F", "H"]]
        end
        subject(:board_anti_diag) { described_class.new(grid_anti_diag_win) }
        it "returns true" do
          expect(board_anti_diag).to be_game_over
        end
      end
    end

    context "when no line of four is made" do
      let(:grid_no_winner) do
        [["S", nil, nil, nil, nil, nil, nil],
         ["C", nil, nil, "D", nil, nil, nil],
         ["I", nil, "S", "I", nil, "D", nil],
         ["T", "G", "W", "V", "G", "N", nil],
         ["T", "A", "O", "A", "G", "I", nil],
         ["A", "B", "C", "D", "E", "F", nil]]
      end
      subject(:board_no_win) { described_class.new(grid_no_winner) }
      it "returns false" do
        expect(board_no_win).not_to be_game_over
      end
    end
  end
end
