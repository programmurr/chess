# frozen_string_literal: true

# Compares player and board information to determine if moves are valid
class MoveChecks
  attr_reader :player, :board

  def initialize(player, board)
    @player = player
    @board = board
  end

  def king_under_threat?(cells_under_attack)
    return false if cells_under_attack.nil? || start_cell.value.class != King
    return true if cells_under_attack.include?(end_cell.co_ord)

    false
  end

  def new_check?(cells_under_attack, king_cell)
    return true if cells_under_attack.include?(king_cell.co_ord)

    false
  end

  def in_check?(black_check_cells, white_check_cells, white_king_cell, black_king_cell)
    if player.color == 'White' && black_check_cells.include?(white_king_cell.co_ord)
      true
    elsif player.color == 'Black' && white_check_cells.include?(black_king_cell.co_ord)
      true
    else
      false
    end
  end

  def checkmate?(cells_under_attack, king_cell)
    array_co_ord = board.get_cell_grid_co_ord(king_cell.co_ord)
    adjascent_king_cells = king_cell.value.adjascent_cells(array_co_ord, board)
    return true if new_check?(cells_under_attack, king_cell) && (adjascent_king_cells - cells_under_attack) == []

    false
  end

  def stalemate?(cells_under_attack, king_cell, board)
    array_co_ord = board.get_cell_grid_co_ord(king_cell.co_ord)
    move_hash = king_cell.value.all_move_coordinates_from_current_position(array_co_ord, king_cell.value.color)
    move_cells = board.get_cells_from_hash(move_hash)
    clean_move_cells = move_cells.flatten(2).delete_if { |element| element.is_a? String }.map(&:co_ord).sort
    return true if clean_move_cells - cells_under_attack == []

    false
  end

  def promote_pawn?
    (board.grid[7] + board.grid[0]).each do |cell|
      next if cell.value.nil?
      return true if cell.value.class == Pawn
    end
    false
  end

  def castle?(check_cells)
    return false unless player.move.include?('castle')

    move_co_ord = player.move[-2, 2]
    cells = board.get_castle_cells(move_co_ord)
    return false if cells[0].value.nil? || cells[-1].value.nil?
    return false if player.color != cells[0].value.color || player.color != cells[-1].value.color

    cells[1...-1].each do |cell|
      return false unless cell.value.nil?
    end

    unless check_cells.nil?
      cells.each do |cell|
        return false if check_cells.include?(cell.co_ord)
      end
    end
    return true if cells[0].value.number_of_moves.zero? && cells[-1].value.number_of_moves.zero?

    false
  end

  def end_cell_matches_player_color?
    unless end_cell.value.nil?
      return true if end_cell.value.color == player.color
    end
    false
  end

  def start_cell_contains_piece?
    return true unless start_cell.value.nil?

    false
  end

  def matching_piece_class?
    return true if start_cell.value.color == player.color

    false
  end

  private

  def end_cell
    board.get_cell(player.move[1]) if player.move.length == 2
  end

  def start_cell
    board.get_cell(player.move[0]) if player.move.length == 2
  end
end
