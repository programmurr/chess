# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'player_board_interface'
require_relative 'move_checks'

class GamePlay
  attr_accessor :board, :player1, :player2, :active_player, :next_player

  def initialize(board: Board.new, player1: Player.new(1), player2: Player.new(2))
    @board = board
    @player1 = player1
    @player2 = player2
    @active_player = nil
    @next_player = nil
  end

  def setup_board
    board.setup
  end

  def assign_player1_white_piece
    player1.assign_white_piece
    player2.assign_black_piece
  end

  def assign_player2_white_piece
    player1.assign_black_piece
    player2.assign_white_piece
  end

  def player1_as_active_player
    self.active_player = player1
    self.next_player = player2
  end

  def player2_as_active_player
    self.active_player = player2
    self.next_player = player1
  end

  def switch_active_player
    temp = active_player
    self.active_player = next_player
    self.next_player = temp
  end

  def enter_move
    loop do
      begin
      active_player.enter_move
      rescue RuntimeError
        retry
    end
      @move_check = MoveChecks.new(active_player, board)
      @move_check.cell_contains_piece?
      break if @move_check.matching_piece_class?

      puts 'Please select a piece matching your color'
      sleep 2
    end
  end

  def refresh_display
    system 'clear'
    player1.display_captured_pieces
    player2.display_captured_pieces
    board.display
  end

  def test_loop
    loop do
      refresh_display
      enter_move
      if @move_check.piece_a_whitepawn?
        piece = board.get_cell(active_player.move[0]).value
        co_ord = board.get_cell_grid_co_ord(active_player.move[0])
        moves = piece.all_move_coordinates_from_current_position(co_ord)
        cells = board.get_cells_from_hash(moves)
        @move_check.white_pawn_attack_filter(cells)
        @move_check.white_pawn_non_attack_filter(cells)
        if @move_check.valid_move?(cells, active_player.move[1])
          interface = PlayerBoardInterface.new(active_player, board)
          interface.move_piece
          interface.take_enemy_piece
        end
      elsif @move_check.piece_a_blackpawn?
        piece = board.get_cell(active_player.move[0]).value
        co_ord = board.get_cell_grid_co_ord(active_player.move[0])
        moves = piece.all_move_coordinates_from_current_position(co_ord)
        cells = board.get_cells_from_hash(moves)
        @move_check.black_pawn_attack_filter(cells)
        @move_check.black_pawn_non_attack_filter(cells)
        if @move_check.valid_move?(cells, active_player.move[1])
          interface = PlayerBoardInterface.new(active_player, board)
          interface.move_piece
          interface.take_enemy_piece
        end
      end
      switch_active_player
    end
  end
end

game = GamePlay.new
game.setup_board
game.assign_player1_white_piece
game.player1_as_active_player
game.test_loop
