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
    return true if cell.value.class.superclass.to_s == player.piece

    false
  end

  def self.valid_move?(player, board)
    # get piece to be moved
    start_cell = board.get_cell(player.move[0])
    end_cell = board.get_cell(player.move[1])
    # get it's grid coordinates (NOT the Cell.co_ord)
    start_co_ords = board.get_cell_grid_co_ord(player.move[0])
    end_co_ords = board.get_cell_grid_co_ord(player.move[1])
    # get the formula for that piece's moves
    # generate ALL possible moves
    class_name = start_cell.value.class.to_s
    move_array = player.piece.valid_moves(start_co_ords, class_name)
    # remove a move if:
    # - it goes off the board
    move_array.select! do |co_ord|
      co_ord[0] >= 0 && co_ord[1] >= 0
      co_ord[0] < 8 && co_ord[1] < 8
    end
    cell_strings = move_array.map { |co_ord| board.get_cell_string_co_ord(co_ord) }
    cells = cell_strings.map { |co_ord| board.get_cell(co_ord) }
    cells.select! { |cell| cell.value.nil? || cell.value.class.superclass.to_s == 'BlackPiece' }
    return true if cells.length > 0

    false
    # - a piece blocks it
    # - a condition particular to it is truthy/falsey e.g. WhitePawn#first_move?
  end
end
