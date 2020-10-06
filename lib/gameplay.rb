# frozen_string_literal: true

require 'colorize'
require_relative 'board'
require_relative 'player'
require_relative 'move_checks'

# Coordinates the game actions and flow
#   This class is getting too big and complicated. Need to refactor
#   Possibly move some logic to move_checks and update tests
class GamePlay
  attr_accessor :board, :player1, :player2, :active_player, :next_player, :en_passant_cache

  def initialize(board: Board.new, player1: Player.new(1), player2: Player.new(2))
    @board = board
    @player1 = player1
    @player2 = player2
    @active_player = nil
    @next_player = nil
    @en_passant_cache = []
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

  def test_loop
    loop do
      refresh_display
      enter_move
      if castle_check?
        execute_castle_move
        break
      end
      cells = change_move_array_to_cells
      piece.move_filter(cells, end_co_ordinate)
      if piece.valid_move?(cells, end_co_ordinate)
        player_move_actions
        execute_promotion if promote_pawn?
        break
      else
        invalid_move_message
      end
    end
    en_passant_actions
    switch_active_player
  end

  def castle_check?
    return false unless active_player.move.include?('castle')

    move_co_ord = active_player.move[-2, 2]
    cells = board.get_castle_cells(move_co_ord)
    first_cell = cells.shift
    last_cell = cells.pop
    return false if first_cell.value.nil? || last_cell.value.nil?
    return false if active_player.color != first_cell.value.color || active_player.color != last_cell.value.color

    cells.each do |cell|
      return false unless cell.value.nil?
    end
    return true if first_cell.value.number_of_moves.zero? && last_cell.value.number_of_moves.zero?

    false
  end

  def move_check
    MoveChecks.new(active_player, board)
  end

  def promote_pawn?
    if active_player.color == 'White'
      return true if white_pawn_on_row?
    elsif active_player.color == 'Black'
      return true if black_pawn_on_row?
    end
    false
  end

  def player_move_actions
    active_player.move_piece(board)
    active_player.take_enemy_piece(board, next_player)
    active_player.move_counter += 1
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

  private

  def place_invisible_pawn
    return if en_passant_cache.length.zero?

    string_co_ord = en_passant_cache[0].co_ord
    array_co_ord = board.grid_coordinate_map.fetch(string_co_ord)
    x = array_co_ord[0]
    y = array_co_ord[1]
    if active_player.color == 'White'
      board.get_cell_from_array_co_ord([x + 1, y]).value = InvisiblePawn.new(array_co_ord)
    elsif active_player.color == 'Black'
      board.get_cell_from_array_co_ord([x - 1, y]).value = InvisiblePawn.new(array_co_ord)
    end
  end

  def remove_invisible_pawn
    board.grid.each do |row|
      row.each do |cell|
        if cell.value.nil?
          next
        elsif cell.value.class == InvisiblePawn
          cell.value = nil
        end
      end
    end
  end

  def clear_en_passant_cache
    self.en_passant_cache = []
  end

  def set_en_passant_to_false
    board.grid[3].each do |cell|
      if cell.value.nil?
        next
      elsif cell.value.class == Pawn && cell.value.en_passant
        cell.value.en_passant = false
        cell.value.number_of_moves += 1
      end
    end
    board.grid[4].each do |cell|
      if cell.value.nil?
        next
      elsif cell.value.class == Pawn && cell.value.en_passant
        cell.value.en_passant = false
        cell.value.number_of_moves += 1
      end
    end
  end

  def set_en_passant_to_true
    board.grid[3].each do |cell|
      if cell.value.nil?
        next
      elsif cell.value.class == Pawn && cell.value.number_of_moves == 1
        cell.value.en_passant = true
      end
    end
    board.grid[4].each do |cell|
      if cell.value.nil?
        next
      elsif cell.value.class == Pawn && cell.value.number_of_moves == 1
        cell.value.en_passant = true
      end
    end
  end

  def add_to_en_passant_cache
    board.grid[3].each do |cell|
      if cell.value.nil? || cell.value.class != Pawn
        next
      elsif cell.value.en_passant
        en_passant_cache << cell
      end
    end
    board.grid[4].each do |cell|
      if cell.value.nil? || cell.value.class != Pawn
        next
      elsif cell.value.en_passant
        en_passant_cache << cell
      end
    end
  end

  def black_pawn_on_row?
    board.grid[7].each do |cell|
      next if cell.value.nil?
      return true if cell.value.class == Pawn
    end
    false
  end

  def white_pawn_on_row?
    board.grid[0].each do |cell|
      next if cell.value.nil?
      return true if cell.value.class == Pawn
    end
    false
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
      if castle_check?
        break
      elsif castle_check? == false && active_player.move.include?('castle')
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

game = GamePlay.new
game.setup_board
game.assign_player1_white_piece
game.player1_as_active_player
loop do
  game.test_loop
end
