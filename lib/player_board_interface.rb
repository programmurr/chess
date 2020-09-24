# frozen_string_literal: true

require 'pry'
require_relative 'board'
require_relative 'player'

# Create a validation class/module, to validate moves, then trigger a move via this class
class PlayerBoardInterface
  attr_reader :player, :board
  attr_accessor :start_cell, :end_cell

  def initialize(player, board)
    @player = player
    @board = board
    @start_cell = board.get_cell(player.move[0])
    @end_cell = board.get_cell(player.move[1])
  end

  def move_piece
    end_cell.value = start_cell.value
    start_cell.value = nil
  end

  def cell_contains_piece?
    return true unless start_cell.value.nil?

    false
  end

  def matching_piece_class?
    return true if start_cell.value.color == player.color

    false
  end

  # Does this belong here?
  def attack_move?
    return false if end_cell.value.nil?
    return true if start_cell.value.color != end_cell.value.color
  end
end

# player = Player.new(1)
# player.move = %w[a2 a4]
# board = Board.new
# board.set_cell_coordinates
# board.place_pawns
# board.place_royalty
# board.display
# PlayerBoardInterface.move_piece(player, board)
# board.display
