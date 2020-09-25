# frozen_string_literal: true

require_relative 'board'
require_relative 'player'
require_relative 'player_board_interface'
require_relative 'move_checks'

board = Board.new
board.setup

player1 = Player.new(1)
player2 = Player.new(2)
player1.assign_white_piece
player2.assign_black_piece

# begin
#   player1.enter_move
# rescue RuntimeError
#   retry
# end
player1.move = %w[a2 a4]

move_check = MoveChecks.new(player1, board)
move_check.cell_contains_piece?
move_check.matching_piece_class?
if move_check.piece_a_whitepawn?
  piece = board.get_cell(player1.move[0]).value
  co_ord = board.get_cell_grid_co_ord(player1.move[0])
  moves = piece.all_move_coordinates_from_current_position(co_ord)
  binding.pry
  cells = board.get_cells_from_hash(moves)
elsif move_check.piece_a_blackpawn?
  # code
end
