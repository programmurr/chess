require_relative 'move_formulas'

# This class might need renamed, as MoveFormulas does most of the leg work for move calculations
#   Rename to MoveRules, or something similar?
class Moves
  attr_reader :player, :board, :start_cell, :end_cell, :piece, :start_co_ords, :end_co_ords

  def initialize(player, board)
    @player = player
    @piece = player.piece
    @board = board
    @start_cell = get_start_cell(player, board)
    @end_cell = get_end_cell(player, board)
    @start_co_ords = get_start_co_ords(player, board)
    @end_co_ords = get_end_co_ords(player, board)
  end

  def valid_move?
    selected_piece_class_name = start_cell.value.class.to_s
    total_moves = all_moves(start_co_ords, selected_piece_class_name)
    binding.pry
    possible_moves = remove_moves_beyond_the_board(total_moves)
    cells = get_cells_from_move_array(possible_moves, board)
    # binding.pry
    filter_cells_with_same_color_pieces(cells)
    chop_cells_blocked_by_a_piece(cells)
    # binding.pry
    return false if cells.length.zero?

    cells.select! { |cell| cell.co_ord == end_cell.co_ord }
    return false if cells.length.zero?

    true
  end

  private

  def chop_cells_blocked_by_a_piece(cells)
    # Get cells between current cell and destination
    # Turn move_array into a hash?
    # If the end cell is inside the left key, filter out the left moves?
    # If the cells are not consecutive, remove it?
    # How to traverse the cells consecutively? Use a queue?
    # Have a consecutive order returned my move_array, filter out cells containing pieces
    # If the consecutive array does not match the array after that filter, it's invalid?
    # binding.pry
  end

  def all_moves(co_ord, class_name)
    moves_hash = { 'Pawn' => pawn(co_ord),
                   'Rook' => MoveFormulas.new(co_ord).rook,
                   'Bishop' => MoveFormulas.new(co_ord).bishop,
                   'Knight' => MoveFormulas.new(co_ord).knight,
                   'Queen' => MoveFormulas.new(co_ord).queen,
                   'King' => MoveFormulas.new(co_ord).king }
    moves_hash.fetch(class_name)
  end

  # HACK: Keep an eye for when I can refactor this into #all_moves
  def pawn(co_ord)
    if start_cell.value.color == 'White'
      MoveFormulas.new(co_ord).white_pawn
    elsif start_cell.value.color == 'Black'
      MoveFormulas.new(co_ord).black_pawn
    end
  end

  def get_end_co_ords(player, board)
    board.get_cell_grid_co_ord(player.move[1])
  end

  def get_start_co_ords(player, board)
    board.get_cell_grid_co_ord(player.move[0])
  end

  def get_start_cell(player, board)
    board.get_cell(player.move[0])
  end

  def get_end_cell(player, board)
    board.get_cell(player.move[1])
  end

  def filter_cells_with_same_color_pieces(cells)
    cells.select! { |cell| cell.value.nil? || cell.value.class.superclass.to_s == self.class.superclass.to_s }
  end

  def remove_moves_beyond_the_board(move_array)
    possible_array = []
    move_array.each do |co_ord|
      next unless co_ord[0] < 8 && co_ord[1] < 8

      possible_array << co_ord if !co_ord[0].negative? && !co_ord[1].negative?
    end
    possible_array
  end

  def get_cells_from_move_array(move_array, board)
    cell_strings = move_array.map { |co_ord| board.get_cell_string_co_ord(co_ord) }
    cell_strings.map { |co_ord| board.get_cell(co_ord) }
  end
end
