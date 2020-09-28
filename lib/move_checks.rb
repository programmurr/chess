# frozen_string_literal: true

class MoveChecks
  attr_reader :player, :board
  attr_accessor :start_cell, :end_cell, :temp_cell

  def initialize(player, board)
    @player = player
    @board = board
    @start_cell = board.get_cell(player.move[0])
    @end_cell = board.get_cell(player.move[1])
    @temp_cell = nil
  end

  def end_cell_matches_player_color?
    unless end_cell.value.nil?
      return true if end_cell.value.color == player.color
    end
    false
  end

  def valid_move?(cells, end_co_ord)
    cells.each_value do |move|
      move.each do |position|
        return true if end_co_ord == position.co_ord
      end
    end
    false
  end

  def cell_contains_piece?
    return true unless start_cell.value.nil?

    false
  end

  def matching_piece_class?
    return true if start_cell.value.color == player.color

    false
  end

  def attack_move?
    return false if end_cell.value.nil?
    return true if start_cell.value.color != end_cell.value.color
  end
end
