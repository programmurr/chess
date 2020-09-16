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

    it 'returns true if the Knight can move to an empty square' do
      player = double('Player', move: %w[g1 f3], piece: WhitePiece.new)
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end

    it 'returns false if Knight tries to move to a square with the same piece color' do
      player = double('Player', move: %w[g1 e2], piece: WhitePiece.new)
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns false if Knight tries to move to a square outside the board' do
      player = double('Player', move: %w[g1 e2], piece: WhitePiece.new)
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq false
    end

    it 'returns true if the Rook can move to an empty square' do
      player = double('Player', move: %w[f4 b4], piece: WhitePiece.new)
      @board.grid[4][5].value = WhiteRook.new
      # @board.display
      move = Moves.new(player, @board)
      expect(move.valid_move?).to eq true
    end
  end
end
