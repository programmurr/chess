# frozen_string_literal: true

require_relative '../lib/move_checks'

context MoveChecks do
  before do
    @board = Board.new
    @board.set_cell_coordinates
    @board.place_pawns
    @board.place_royalty
  end

  context '#cell_contains_piece?' do
    it 'returns true if the cell contains a piece to be moved' do
      player = double('Player', move: %w[h2 h3])
      expect(MoveChecks.new(player, @board).cell_contains_piece?).to eq true
    end

    it 'returns false if the cell does not contain a piece to be moved' do
      player = double('Player', move: %w[h3 h5])
      expect(MoveChecks.new(player, @board).cell_contains_piece?).to eq false
    end
  end

  context '#matching_piece_class?' do
    it "returns 'true' if the player piece class matches the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'White')
      expect(MoveChecks.new(player, @board).matching_piece_class?).to eq true
    end

    it "returns 'false' if the player piece class does not match the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'Black')
      expect(MoveChecks.new(player, @board).matching_piece_class?).to eq false
    end
  end

  context '#attack_move?' do
    it 'returns true if the player decides to move a piece to a cell containing an enemy piece' do
      player = double('Player', move: %w[c4 f4], color: 'Black')
      @board.grid[4][2].value = Rook.new('Black')
      @board.grid[4][5].value = WhitePawn.new('White')
      expect(MoveChecks.new(player, @board).attack_move?).to eq true
    end

    it 'returns false if the player decides to move a piece to an empty cell' do
      player = double('Player', move: %w[b6 e3], color: 'Black')
      @board.grid[2][1].value = Queen.new('White')
      expect(MoveChecks.new(player, @board).attack_move?).to eq false
    end
  end

  context '#piece_a_whitepawn?' do
    it 'returns true if the piece to be moved is a white pawn' do
      player = double('Player', move: %w[h2 h4], color: 'White')
      expect(MoveChecks.new(player, @board).piece_a_whitepawn?).to eq true
    end

    it 'returns false if the piece to be moved is not a white pawn' do
      player = double('Player', move: %w[b1 c3], color: 'White')
      expect(MoveChecks.new(player, @board).piece_a_whitepawn?).to eq false
    end
  end

  context '#piece_a_blackpawn?' do
    it 'returns true if the piece to be moved is a black pawn' do
      player = double('Player', move: %w[e7 e6], color: 'Black')
      expect(MoveChecks.new(player, @board).piece_a_blackpawn?).to eq true
    end

    it 'returns false if the piece to be moved is not a black pawn' do
      player = double('Player', move: %w[g8 h6], color: 'Black')
      expect(MoveChecks.new(player, @board).piece_a_blackpawn?).to eq false
    end
  end

  # context '#permit_special_move?' do
  #   xit 'lets a white pawn move forward 2 spaces on its first move' do
  #     player = double('Player', move: %w[f2 f4], color: 'White')
  #     expect(MoveChecks.new(player, @board).permit_special_move?).to eq true
  #   end
  # end

  # context '#piece_blocking_path?' do
  #   xit 'returns true if there is an enemy piece blocking the move' do
  #   end

  #   xit 'returns true if there is a friendly piece blocking the move' do
  #   end

  #   xit 'returns false if the path of the move is clear' do
  #   end
  # end
end

# For the 'must not jump over another piece' problem:
#   Generate all possible moves as before
#   If any  of those moves contain a self piece or enemy piece and it's not the end cell:
#      remove that move
#   If no remaining moves contain end cell, that move cannot take place
