# frozen_string_literal: true

# Compares player and board information to determine if moves are valid
class MoveChecks
  attr_reader :player, :board

  def initialize(player, board)
    @player = player
    @board = board
  end

  def promote_pawn?
    (board.grid[7] + board.grid[0]).each do |cell|
      next if cell.value.nil?
      return true if cell.value.class == Pawn
    end
    false
  end

  def castle_check?
    return false unless player.move.include?('castle')

    move_co_ord = player.move[-2, 2]
    cells = board.get_castle_cells(move_co_ord)
    return false if cells[0].value.nil? || cells[-1].value.nil?
    return false if player.color != cells[0].value.color || player.color != cells[-1].value.color

    cells[1...-1].each do |cell|
      return false unless cell.value.nil?
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
