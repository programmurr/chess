# frozen_string_literal: true

require_relative '../lib/player_board_interface'

describe PlayerBoardInterface do
  before do
    @board = Board.new
    @board.set_cell_coordinates
    @board.place_pawns
    @board.place_royalty
  end

  context '#cell_contains_piece?' do
    it 'returns true if the cell contains a piece to be moved' do
      player = double('Player', move: %w[h2 h3])
      expect(PlayerBoardInterface.new(player, @board).cell_contains_piece?).to eq true
    end

    it 'returns false if the cell does not contain a piece to be moved' do
      player = double('Player', move: %w[h3 h5])
      expect(PlayerBoardInterface.new(player, @board).cell_contains_piece?).to eq false
    end
  end

  context '#move_piece' do
    it 'can move the selected piece from one square to another' do
      player = double('Player', move: %w[a2 a4])
      expect { PlayerBoardInterface.new(player, @board).move_piece }.to change { @board.grid[4][0].value }.from(nil).to be_instance_of WhitePawn
    end
  end

  context '#matching_piece_class?' do
    it "returns 'true' if the player piece class matches the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'White')
      expect(PlayerBoardInterface.new(player, @board).matching_piece_class?).to eq true
    end

    it "returns 'false' if the player piece class does not match the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'Black')
      expect(PlayerBoardInterface.new(player, @board).matching_piece_class?).to eq false
    end
  end

  context '#attack_move?' do
    it 'returns true if the player decides to move a piece to a cell containing an enemy piece' do
      player = double('Player', move: %w[c4 f4], color: 'Black')
      @board.grid[4][2].value = Rook.new('Black')
      @board.grid[4][5].value = WhitePawn.new('White')
      expect(PlayerBoardInterface.new(player, @board).attack_move?).to eq true
    end

    it 'returns false if the player decides to move a piece to an empty cell' do
      player = double('Player', move: %w[b6 e3], color: 'Black')
      @board.grid[2][1].value = Queen.new('White')
      expect(PlayerBoardInterface.new(player, @board).attack_move?).to eq false
    end
  end
end

# For the 'must not jump over another piece' problem:
#   Generate all possible moves as before
#   If any  of those moves contain a self piece or enemy piece and it's not the end cell:
#      remove that move
#   If no remaining moves contain end cell, that move cannot take place
