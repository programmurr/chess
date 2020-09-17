# frozen_string_literal: true

require 'pry'
require_relative 'board'
require_relative 'player'

class PlayerBoardInterface
  def self.move_piece(player, board)
    start_cell = board.get_cell(player.move[0])
    end_cell = board.get_cell(player.move[1])
    end_cell.value = start_cell.value
    start_cell.value = nil
  end

  def self.valid_piece?(player, board)
    cell = board.get_cell(player.move[0])
    return true if cell.value.color == player.color

    false
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
