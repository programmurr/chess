# frozen_string_literal: true

require_relative '../lib/moves'
require_relative '../lib/board'

describe Moves do
  context '#valid_move?' do
    before do
      @board = Board.new
      @board.set_cell_coordinates
      @board.place_pawns
      @board.place_royalty
    end

    xit 'returns true if the Knight can move to an empty square' do
      player = double('Player', move: %w[g1 f3], piece: Piece.new('White'))
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns false if Knight tries to move to a square not in its move range' do
      player = double('Player', move: %w[g8 g6], piece: Piece.new('Black'))
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns false if Knight tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[g8 e7], piece: Piece.new('Black'))
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns true if the Rook tries to move to an empty square with direct line of sight' do
      player = double('Player', move: %w[f4 b4], piece: Piece.new('White'))
      @board.grid[4][5].value = Rook.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns false if the Rook tries to move to an empty square with any piece blocking the path' do
      player = double('Player', move: %w[f4 a4], piece: Piece.new('White'))
      @board.grid[4][5].value = Rook.new('White')
      @board.grid[4][2].value = Pawn.new('White')
      @board.display
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns false if Rook tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[f4 f7], piece: Piece.new('Black'))
      @board.grid[4][5].value = Rook.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns false if Rook tries to move in an invalid direction' do
      player = double('Player', move: %w[f4 d6], piece: Piece.new('White'))
      @board.grid[4][5].value = Rook.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns true if the Bishop can move to an empty square' do
      player = double('Player', move: %w[e5 c3], piece: Piece.new('Black'))
      @board.grid[3][4].value = Bishop.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns false if Bishop tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[c3 d2], piece: Piece.new('White'))
      @board.grid[5][2].value = Bishop.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns false if Bishop tries to move in an invalid direction' do
      player = double('Player', move: %w[f6 a6], piece: Piece.new('Black'))
      @board.grid[2][5].value = Bishop.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns true if the Queen can move to an empty square in a vertical direction' do
      player = double('Player', move: %w[d3 d6], piece: Piece.new('White'))
      @board.grid[5][3].value = Queen.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns true if the Queen can move to an empty square in a horizontal direction' do
      player = double('Player', move: %w[d5 a5], piece: Piece.new('Black'))
      @board.grid[3][3].value = Queen.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns true if the Queen can move to an empty square in a diagonal direction' do
      player = double('Player', move: %w[g6 d3], piece: Piece.new('White'))
      @board.grid[2][6].value = Queen.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns false if the Queen tries to move in an invalid direction' do
      player = double('Player', move: %w[a3 b5], piece: Piece.new('White'))
      @board.grid[5][0].value = Queen.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns false if Queen tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[h5 h7], piece: Piece.new('Black'))
      @board.grid[3][7].value = Queen.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns true if the King can move to an adjascent empty square (vertical)' do
      player = double('Player', move: %w[e6 e5], piece: Piece.new('Black'))
      @board.grid[2][4].value = King.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns true if the King can move to an adjascent empty square (horizontal)' do
      player = double('Player', move: %w[g4 f4], piece: Piece.new('White'))
      @board.grid[4][6].value = King.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns true if the King can move to an adjascent empty square (diagonal)' do
      player = double('Player', move: %w[h4 g5], piece: Piece.new('Black'))
      @board.grid[4][7].value = King.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    xit 'returns false if the King tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[a3 b2], piece: Piece.new('White'))
      @board.grid[5][0].value = King.new('White')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    xit 'returns false if the King tries to make a move outside its range of motion' do
      player = double('Player', move: %w[a6 d3], piece: Piece.new('Black'))
      @board.grid[2][0].value = King.new('Black')
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end
  end
end
