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
      expect(Moves.valid_move?(player, @board)).to eq true
    end

    it 'returns false if Knight tries to move to a square with the same piece color' do
      player = double('Player', move: %w[g1 e2], piece: WhitePiece.new)
      expect(Moves.valid_move?(player, @board)).to eq false
    end

    it 'returns false if Knight tries to move to a square outside the board' do
      player = double('Player', move: %w[g1 e2], piece: WhitePiece.new)
      expect(Moves.valid_move?(player, @board)).to eq false
    end
  end
end
