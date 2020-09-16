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

    it 'returns true if the WhiteQueen can move to an empty square in a vertical direction' do
      player = double('Player', move: %w[d3 d6], piece: WhitePiece.new)
      @board.grid[5][3].value = WhiteQueen.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns true if the WhiteQueen can move to an empty square in a horizontal direction' do
      player = double('Player', move: %w[a5 e5], piece: WhitePiece.new)
      @board.grid[3][0].value = WhiteQueen.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns true if the WhiteQueen can move to an empty square in a diagonal direction' do
      player = double('Player', move: %w[g6 d3], piece: WhitePiece.new)
      @board.grid[2][6].value = WhiteQueen.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns false if WhiteQueen tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[b5 b2], piece: WhitePiece.new)
      @board.grid[3][1].value = WhiteQueen.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns false if WhiteQueen tries to move in an invalid direction' do
      player = double('Player', move: %w[a3 b5], piece: WhitePiece.new)
      @board.grid[5][0].value = WhiteQueen.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns true if the WhiteKing can move to an adjascent empty square (vertical)' do
      player = double('Player', move: %w[g4 g5], piece: WhitePiece.new)
      @board.grid[4][6].value = WhiteKing.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns true if the WhiteKing can move to an adjascent empty square (horizontal)' do
      player = double('Player', move: %w[g4 f4], piece: WhitePiece.new)
      @board.grid[4][6].value = WhiteKing.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns true if the WhiteKing can move to an adjascent empty square (diagonal)' do
      player = double('Player', move: %w[g4 f5], piece: WhitePiece.new)
      @board.grid[4][6].value = WhiteKing.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns false if the WhiteKing tries to move to a square occupied by the same piece color' do
      player = double('Player', move: %w[a3 b2], piece: WhitePiece.new)
      @board.grid[5][0].value = WhiteKing.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns false if the WhiteKing tries to make an invalid move' do
      player = double('Player', move: %w[a3 a6], piece: WhitePiece.new)
      @board.grid[5][0].value = WhiteKing.new
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end
  end
end
