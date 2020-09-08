# frozen_string_literal: true

require_relative '../lib/board'

describe Board do
  context '#initialize' do
    it 'can create an 8x8 grid made of nested arrays' do
      test_grid = Array.new(8) { Array.new(8) }
      board = Board.new(grid: test_grid)
      expect(board.grid).to be_instance_of Array
    end

    it 'creates a board with 8 columns' do
      board = Board.new
      expect(board.grid.length).to eq 8
    end

    it 'creates a board with 8 rows' do
      board = Board.new
      expect(board.grid[7].length).to eq 8
    end

    it 'instantializes Cell objects as the value of each space on the board' do
      board = Board.new
      expect(board.grid[5][1]).to be_instance_of Cell
    end
  end

  context '#set_cell_coordinates' do
    it 'changes each cell coordinate value from nil to a coordinate string' do
      board = Board.new
      expect { board.set_cell_coordinates }.to change { board.grid[7][0].co_ord }.from(nil).to('a1')
    end
  end

  context '#place_pawns' do
    before do
      @board = Board.new
      @board.set_cell_coordinates
    end

    it 'places white pawns along the 6th row' do
      expect { @board.place_pawns }.to change { @board.grid[6][2].value }.from(nil).to be_instance_of WhitePawn
    end

    it 'places black pawns along the 2nd row' do
      expect { @board.place_pawns }.to change { @board.grid[1][5].value }.from(nil).to be_instance_of BlackPawn
    end
  end

  context '#place_royalty' do
    before do
      @board = Board.new
      @board.set_cell_coordinates
    end

    it 'places the royal black pieces on the first row' do
      expect { @board.place_royalty }.to change { @board.grid[0][4].value }.from(nil).to be_instance_of BlackKing
    end
  end
end
