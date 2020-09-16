require_relative '../../lib/pieces/moves'
require_relative '../../lib/board'

describe Moves do
  context '#valid_move?' do
    before do
      @board = Board.new
      @board.set_cell_coordinates
      @board.place_pawns
      @board.place_royalty
    end

    it 'returns true if the WhiteKnight can move to an empty square' do
      player = double('Player', move: %w[g1 f3], piece: WhitePiece.new)
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns false if WhiteKnight tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[g1 e2], piece: WhitePiece.new)
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns false if WhiteKnight tries to move to a square not in its move range' do
      player = double('Player', move: %w[g1 g2], piece: WhitePiece.new)
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns true if the WhiteRook can move to an empty square' do
      player = double('Player', move: %w[f4 b4], piece: WhitePiece.new)
      @board.grid[4][5].value = WhiteRook.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns false if WhiteRook tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[f4 f2], piece: WhitePiece.new)
      @board.grid[4][5].value = WhiteRook.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns false if WhiteRook tries to move in an invalid direction' do
      player = double('Player', move: %w[f4 d6], piece: WhitePiece.new)
      @board.grid[4][5].value = WhiteRook.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns true if the WhiteBishop can move to an empty square' do
      player = double('Player', move: %w[c3 e5], piece: WhitePiece.new)
      @board.grid[5][2].value = WhiteBishop.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns false if WhiteBishop tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[c3 d2], piece: WhitePiece.new)
      @board.grid[5][2].value = WhiteBishop.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns false if WhiteBishop tries to move in an invalid direction' do
      player = double('Player', move: %w[c3 h3], piece: WhitePiece.new)
      @board.grid[5][2].value = WhiteBishop.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end
  end
end
