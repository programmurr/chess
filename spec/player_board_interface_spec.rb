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
      expect { PlayerBoardInterface.move_piece(player.move, @board) }.to change { @board.grid[4][0].value }.from(nil).to be_instance_of WhitePawn
    end
  end
end
