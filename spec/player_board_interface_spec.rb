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
      expect { PlayerBoardInterface.new(player, @board).move_piece }.to change { @board.grid[4][0].value }.from(nil).to be_instance_of WhitePawn
    end
  end

  context '#take_enemy_piece' do
    before do
      @player = Player.new(1)
      @player.color = 'White'
      @player.move = %w[b3 g3]
      @board.grid[5][1].value = Rook.new('Black')
      @board.grid[5][6].value = Knight.new('Black')
      @interface = PlayerBoardInterface.new(@player, @board)
      @interface.move_piece
    end

    it "places the captured piece into the player's captured pieces attribute" do
      expect { @interface.take_enemy_piece }.to change { @player.captured_pieces }
    end
  end
end
