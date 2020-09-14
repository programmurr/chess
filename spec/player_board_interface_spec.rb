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
      expect { PlayerBoardInterface.move_piece(player, @board) }.to change { @board.grid[4][0].value }.from(nil).to be_instance_of WhitePawn
    end
  end

  context '#valid_piece?' do
    it "returns 'true' if the player piece class matches the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], piece: 'WhitePiece')
      expect(PlayerBoardInterface.valid_piece?(player, @board)).to eq true
    end

    it "returns 'false' if the player piece class does not match the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], piece: 'BlackPiece')
      expect(PlayerBoardInterface.valid_piece?(player, @board)).to eq false
    end
  end

  context '#valid_move?' do
    it 'checks if the move is valid for the piece requested to be moved' do
      player = double('Player', move: %w[a2 a4], piece: 'WhitePiece')
      expect(PlayerBoardInterface.valid_move?(player, @board)).to eq true
    end
  end
end
