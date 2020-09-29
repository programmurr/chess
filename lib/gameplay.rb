# frozen_string_literal: true

require 'colorize'
require_relative 'board'
require_relative 'player'
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

  def test_loop
    loop do
      refresh_display
      enter_move
      cells = if piece.class == Knight
                board.get_cells_from_array(moves)
              else
                board.get_cells_from_hash(moves)
              end
      piece.move_filter(cells, end_co_ordinate)
      if piece.valid_move?(cells, end_co_ordinate)
        player_move_actions
        break
      else
        invalid_move_message
      end
    end
    switch_active_player
  end

  private

  def castle_check?
    binding.pry
  end

  def select_correct_piece_message
    puts 'Please select a piece matching your color'.colorize(:red)
    sleep 2
  end

  def attack_own_piece_message
    puts 'You cannot attack your own pieces'.colorize(:red)
    sleep 2
  end

  def user_move_input
    active_player.enter_move
  rescue RuntimeError
    select_correct_piece_message
    refresh_display
    retry
  end

  def move_check
    MoveChecks.new(active_player, board)
  end

  def enter_move
    loop do
      user_move_input
      if castle_check?
      # execute Castle move
      elsif move_check.start_cell_contains_piece? == false || move_check.matching_piece_class? == false
        select_correct_piece_message
        refresh_display
      elsif move_check.end_cell_matches_player_color?
        attack_own_piece_message
        refresh_display
      else
        break
      end
    end
  end

  def refresh_display
    system 'clear'
    player1.display_captured_pieces
    player2.display_captured_pieces
    board.display
  end

  def invalid_move_message
    puts 'That is not valid, please re-enter your move'.colorize(:red)
    sleep 3
  end

  def piece
    board.get_cell(active_player.move[0]).value
  end

  def co_ord
    board.get_cell_grid_co_ord(active_player.move[0])
  end

  def moves
    piece.all_move_coordinates_from_current_position(co_ord)
  end

  def end_co_ordinate
    active_player.move[1]
  end

  def player_move_actions
    active_player.move_piece(board)
    active_player.take_enemy_piece
  end
end

game = GamePlay.new
game.setup_board
game.assign_player1_white_piece
game.player1_as_active_player
loop do
  game.test_loop
end
