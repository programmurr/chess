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
      @board.place_royalty
      @test_row = [Cell.new, Cell.new, Cell.new, Cell.new, Cell.new, Cell.new, Cell.new, Cell.new]
      @test_row[0].value = BlackRook.new
      @test_row[1].value = BlackKnight.new
      @test_row[2].value = BlackBishop.new
      @test_row[3].value = BlackQueen.new
      @test_row[4].value = BlackKing.new
      @test_row[5].value = BlackBishop.new
      @test_row[6].value = BlackKnight.new
      @test_row[7].value = BlackRook.new
      @test_row2 = [Cell.new, Cell.new, Cell.new, Cell.new, Cell.new, Cell.new, Cell.new, Cell.new]
      @test_row2[0].value = WhiteRook.new
      @test_row2[1].value = WhiteKnight.new
      @test_row2[2].value = WhiteBishop.new
      @test_row2[3].value = WhiteQueen.new
      @test_row2[4].value = WhiteKing.new
      @test_row2[5].value = WhiteBishop.new
      @test_row2[6].value = WhiteKnight.new
      @test_row2[7].value = WhiteRook.new
    end

    it 'puts a black rook in a8' do
      expect(@board.grid[0][0].value.class).to eql @test_row[0].value.class
    end

    it 'puts a black knight in b8' do
      expect(@board.grid[0][1].value.class).to eql @test_row[1].value.class
    end

    it 'puts a black bishop in c8' do
      expect(@board.grid[0][2].value.class).to eql @test_row[2].value.class
    end

    it 'puts a black queen in d8' do
      expect(@board.grid[0][3].value.class).to eql @test_row[3].value.class
    end

    it 'puts a black king in e8' do
      expect(@board.grid[0][4].value.class).to eql @test_row[4].value.class
    end

    it 'puts a black bishop in f8' do
      expect(@board.grid[0][5].value.class).to eql @test_row[5].value.class
    end

    it 'puts a black knight in g8' do
      expect(@board.grid[0][6].value.class).to eql @test_row[6].value.class
    end

    it 'puts a black rook in h8' do
      expect(@board.grid[0][7].value.class).to eql @test_row[7].value.class
    end

    it 'puts a white rook in a1' do
      expect(@board.grid[7][0].value.class).to eql @test_row2[0].value.class
    end

    it 'puts a white knight in b1' do
      expect(@board.grid[7][1].value.class).to eql @test_row2[1].value.class
    end

    it 'puts a white bishop in c1' do
      expect(@board.grid[7][2].value.class).to eql @test_row2[2].value.class
    end

    it 'puts a white queen in d1' do
      expect(@board.grid[7][3].value.class).to eql @test_row2[3].value.class
    end

    it 'puts a white king in e1' do
      expect(@board.grid[7][4].value.class).to eql @test_row2[4].value.class
    end

    it 'puts a white bishop in f1' do
      expect(@board.grid[7][5].value.class).to eql @test_row2[5].value.class
    end

    it 'puts a white knight in g1' do
      expect(@board.grid[7][6].value.class).to eql @test_row2[6].value.class
    end

    it 'puts a white rook in h1' do
      expect(@board.grid[7][7].value.class).to eql @test_row2[7].value.class
      @board.display
    end
  end
end
