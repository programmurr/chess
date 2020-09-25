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

  def white_pawn_attack_move?
    #  Is there an enemy piece to the top-right diagonal of the pawn?
    #   Yes - let that move remain in the move array
    #   No - remove that move from the move array
    # Is there an enemy piece to the top-left diagonal of the pawn?
    #   Yes - let that move remain in the move array
    #   No - remove that move from the move array
  end

  def black_pawn_attack_move?
    #  Is there an enemy piece to the down-right diagonal of the pawn?
    #   Yes - let that move remain in the move array
    #   No - remove that move from the move array
    # Is there an enemy piece to the down-left diagonal of the pawn?
    #   Yes - let that move remain in the move array
    #   No - remove that move from the move array
  end

  def attack_move?
    return false if end_cell.value.nil?
    return true if start_cell.value.color != end_cell.value.color
  end
end

# Gets the posible moves from a piece
# Compares it to the player's proposed move
# Triggers the move in PBI if valid
# Denies the move if it is not
# Keep a list of cells that could be moved to by a piece
