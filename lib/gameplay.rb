# frozen_string_literal: true

require 'colorize'
require 'observer'
require_relative 'board'
require_relative 'player'
require_relative 'move_checks'

# Coordinates the game actions and flow
#   This class is getting too big and complicated. Need to refactor
#   Possibly move some logic to move_checks and update tests
class GamePlay
  include Observable

  attr_accessor :board, :player1, :player2, :active_player, :next_player, :en_passant_cache

  def initialize(board: Board.new, player1: Player.new(1), player2: Player.new(2))
    @board = board
    @player1 = player1
    @player2 = player2
    @active_player = nil
    @next_player = nil
    @en_passant_cache = nil
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

  def change_move_array_to_cells
    if piece.class == Knight
      board.get_cells_from_array(moves)
    else
      board.get_cells_from_hash(moves)
    end
  end

  # If check is true, the king MUST be moved out of danger
  # The next move must remove it from the cells under attack list
  # If checkmate - game over
  def test_loop
    loop do
      refresh_display
      enter_move
      if move_check.castle?
        execute_castle_move
        break
      end
      cells = change_move_array_to_cells
      piece.move_filter(cells, end_co_ordinate)
      if piece.valid_move?(cells, end_co_ordinate)
        player_move_actions
        execute_promotion if move_check.promote_pawn?
        game_over_checks
        break
      else
        invalid_move_message
      end
    end
    en_passant_actions
    switch_active_player
  end

  # Test check/mate/stalemate scenarios. Should be working
  def cells_under_attack
    attack_array = []
    final_array = []
    board.grid.each do |row|
      row.each do |cell|
        next if cell.value.nil? || cell.value.color == next_player.color

        co_ord = board.get_cell_grid_co_ord(cell.co_ord)
        moves = cell.value.all_move_coordinates_from_current_position(co_ord, cell.value.color)
        move_cells = if cell.value.class == Knight
                       board.get_cells_from_array(moves)
                     else
                       board.get_cells_from_hash(moves)
                     end
        attack_array << cell.value.check_move_filter(move_cells, next_player)
      end
    end
    attack_array.flatten.uniq.each do |cell|
      final_array << cell if cell.value.nil? || cell.value.color != active_player.color  
    end
    final_array.map(&:co_ord).sort
  end

  def move_check
    MoveChecks.new(active_player, board)
  end

  def execute_promotion
    promotion_message
    cell = board.get_cell(active_player.move[1])
    choice = $stdin.gets.chomp.to_s.downcase.capitalize
    cell.value = promotion_choice(choice)
  rescue KeyError
    puts "Please enter either 'Bishop', 'Rook', 'Knight' or 'Queen'"
    sleep 2
    retry
  end

  def en_passant_actions
    remove_invisible_pawn
    set_en_passant_to_false
    clear_en_passant_cache
    set_en_passant_to_true
    add_to_en_passant_cache
    place_invisible_pawn
  end

  def player_move_actions
    active_player.move_piece(board)
    active_player.take_enemy_piece(board)
    active_player.move_counter += 1
  end

  private

  def game_over_checks
    if move_check.check?(cells_under_attack, king_cell)
      puts 'Check!'
      sleep 2
    end
    if move_check.checkmate?(cells_under_attack, king_cell)
      puts 'Checkmate!'
      sleep 2
    end
    if move_check.stalemate?(cells_under_attack, king_cell, board)
      puts 'Stalemate!'
      sleep 2
    end
  end

  def king_cell
    board.grid.each do |row|
      row.each do |cell|
        return cell if cell.value.class == King && cell.value.color == next_player.color
      end
    end
  end

  def place_invisible_pawn
    return if en_passant_cache.nil?

    enemy_cell = board.get_cell(en_passant_cache.co_ord)
    array_co_ord = board.grid_coordinate_map.fetch(en_passant_cache.co_ord)
    x = array_co_ord[0]
    y = array_co_ord[1]
    if active_player.color == 'White'
      board.get_cell_from_array_co_ord([x + 1, y]).value = InvisiblePawn.new(enemy_cell, active_player.color)
    elsif active_player.color == 'Black'
      board.get_cell_from_array_co_ord([x - 1, y]).value = InvisiblePawn.new(enemy_cell, active_player.color)
    end
  end

  def remove_invisible_pawn
    board.grid.each do |row|
      row.each do |cell|
        next if cell.value.nil? || cell.value.class != InvisiblePawn

        cell.value = nil
      end
    end
  end

  def clear_en_passant_cache
    self.en_passant_cache = nil
  end

  def set_en_passant_to_false
    (board.grid[3] + board.grid[4]).each do |cell|
      next if cell.value.nil? || cell.value.class != Pawn

      if cell.value.en_passant
        cell.value.en_passant = false
        cell.value.number_of_moves += 1
      end
    end
  end

  def set_en_passant_to_true
    (board.grid[3] + board.grid[4]).each do |cell|
      next if cell.value.nil? || cell.value.class != Pawn

      cell.value.en_passant = true if cell.value.number_of_moves == 1
    end
  end

  def add_to_en_passant_cache
    (board.grid[3] + board.grid[4]).each do |cell|
      next if cell.value.nil? || cell.value.class != Pawn

      self.en_passant_cache = cell if cell.value.en_passant
    end
  end

  def promotion_choice(choice)
    { 'Rook' => Rook.new(active_player.color),
      'Queen' => Queen.new(active_player.color),
      'Bishop' => Bishop.new(active_player.color),
      'Knight' => Knight.new(active_player.color) }.fetch(choice)
  end

  def promotion_message
    puts "Your pawn has landed on the last row of the board!\n
    According to the FIDE laws of chess, you must promote this piece!\n
    Enter 'queen', 'bishop', 'rook' or 'knight' to promote your pawn to that piece and finish the move".colorize(:green)
  end

  def user_move_input
    active_player.enter_move
  rescue RuntimeError
    invalid_move_message
    refresh_display
    retry
  end

  def execute_castle_move
    case active_player.move[-2, 2]
    when 'a1'
      board.execute_a1_castle
    when 'a8'
      board.execute_a8_castle
    when 'h1'
      board.execute_h1_castle
    when 'h8'
      board.execute_h8_castle
    end
  end

  def enter_move
    loop do
      user_move_input
      if move_check.castle?
        break
      elsif move_check.castle? == false && active_player.move.include?('castle')
        invalid_move_message
        refresh_display
      elsif move_check.start_cell_contains_piece? == false || move_check.matching_piece_class? == false
        invalid_move_message
        refresh_display
      elsif move_check.end_cell_matches_player_color?
        invalid_move_message
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
    piece.all_move_coordinates_from_current_position(co_ord, active_player.color)
  end

  def end_co_ordinate
    active_player.move[1]
  end
end

# game = GamePlay.new
# game.setup_board
# game.assign_player1_white_piece
# game.player1_as_active_player
# loop do
#   game.test_loop
# end
