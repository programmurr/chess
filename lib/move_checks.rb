# frozen_string_literal: true

require_relative 'player_board_interface'

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

  def valid_move?(cells, end_co_ord)
    cells.each_value do |move|
      move.each do |position|
        return true if end_co_ord == position.co_ord
      end
    end
    false
  end

  def piece_a_whitepawn?
    return true if start_cell.value.class == WhitePawn

    false
  end

  def piece_a_blackpawn?
    return true if start_cell.value.class == BlackPawn

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

  def white_pawn_non_attack_filter(cells)
    # binding.pry
    unless cells['up'].empty?
      cells['up'] = [] unless cells['up'][0].value.nil?
    end
    unless cells['double_up'].empty?
      cells['double_up'] = [] unless cells['double_up'][0].value.nil?
    end
    cells
  end

  def white_pawn_attack_filter(cells)
    # binding.pry
    unless cells['up_right'].empty?
      cells['up_right'] = [] if cells['up_right'][0].value.nil?
    end
    unless cells['up_left'].empty?
      cells['up_left'] = [] if cells['up_left'][0].value.nil?
    end
    cells
  end

  def black_pawn_non_attack_filter(cells)
    unless cells['down'].empty?
      cells['down'] = [] unless cells['down'][0].value.nil?
    end
    unless cells['double_down'].empty?
      cells['double_down'] = [] unless cells['double_down'][0].value.nil?
    end
    cells
  end

  def black_pawn_attack_filter(cells)
    unless cells['down_right'].empty?
      cells['down_right'] = [] if cells['down_right'][0].value.nil?
    end
    unless cells['down_left'].empty?
      cells['down_left'] = [] if cells['down_left'][0].value.nil?
    end
    cells
  end

  def attack_move?
    return false if end_cell.value.nil?
    return true if start_cell.value.color != end_cell.value.color
  end
end
