# frozen_string_literal: true

require_relative 'board'
require_relative 'player'

class PlayerBoardInterface
  def self.move_piece(move, board)
    start_cell = board.get_cell(move[0])
    end_cell = board.get_cell(move[1])
    end_cell.value = start_cell.value
    start_cell.value = nil
  end
end
