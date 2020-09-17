# frozen_string_literal: true

require_relative '../lib/player_board_interface'

describe PlayerBoardInterface do
  before do
    @board = Board.new
    @board.set_cell_coordinates
    @board.place_pawns
    @board.place_royalty
  end

  context '#move_piece' do
    it 'can move the selected piece from one square to another' do
      player = double('Player', move: %w[a2 a4])
      expect { PlayerBoardInterface.move_piece(player, @board) }.to change { @board.grid[4][0].value }.from(nil).to be_instance_of Pawn
    end
  end

  context '#valid_piece?' do
    it "returns 'true' if the player piece class matches the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'White')
      expect(PlayerBoardInterface.valid_piece?(player, @board)).to eq true
    end

    it "returns 'false' if the player piece class does not match the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'Black')
      expect(PlayerBoardInterface.valid_piece?(player, @board)).to eq false
    end
  end
end

# TODO: These 2 tests should be implemented in a 'Game' class
# i.e. if it receves false from #valid_move, then #move_piece should not trigger

# it 'moves the piece if #valid_move? returns true' do
#   player = double('Player', move: %w[g1 f3], piece: WhitePiece.new)
#   expect { PlayerBoardInterface.move_piece(player, @board) }.to change { @board.grid[5][5].value }.from(nil).to be_instance_of WhiteKnight
# end

# it 'does not move the piece if #valid_move? returns false' do
#   player = double('Player', move: %w[g1 f3], piece: WhitePiece.new)
#   allow(PlayerBoardInterface).to receive(:valid_move?) { false }
#   expect { PlayerBoardInterface.move_piece(player, @board) }.not_to change { @board.grid[5][5].value }
# end
