class Moves
  KNIGHT_MOVES_LIST = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

  attr_reader :player, :board, :start_cell, :end_cell, :piece, :start_co_ords, :end_co_ords

  def self.knight(co_ord)
    KNIGHT_MOVES_LIST.map { |a, b| [co_ord.first + a, co_ord.last + b] }
  end

  def self.rook(co_ord)
    # code
  end

  def self.bishop(co_ord)
    # code
  end

  def self.queen(co_ord)
    # code
  end

  def self.king(co_ord)
    # code
  end

  # 9/14 - HACK: Dry this up
  # 9/15 - Pawns are more complicated than I thought
  # 9/15 - Get the moves for other pieces like knights, rooks, etc. then come back to this
  def self.pawn(co_ord)
    x = co_ord[0]
    y = co_ord[1]
    move_array = []
    move1 =  [x - 1, y]
    move2 =  [x - 2, y]
    move3 =  [x - 1, y - 1] # attack move
    move4 =  [x - 1, y + 1] # attack move
    move_array << move1
    move_array << move2
    move_array << move3
    move_array << move4
    move_array
  end

  def initialize(player, board)
    @player = player
    @piece = player.piece
    @board = board
    @start_cell = get_start_cell(player, board)
    @end_cell = get_end_cell(player, board)
    @start_co_ords = get_start_co_ords(player, board)
    @end_co_ords = get_end_co_ords(player, board)
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

  def valid_move?(_player, board)
    selected_piece_class_name = start_cell.value.class.to_s
    move_array = piece.valid_moves(start_co_ords, selected_piece_class_name) # This be stirring up sheeeit
    remove_moves_beyond_the_board(move_array)
    cells = get_cells_from_move_array(move_array, board)
    filter_cells_with_same_color_pieces(cells)

    return false if cells.length.zero?

    cells.select! { |cell| cell.co_ord == end_cell.co_ord }
    return false if cells.length.zero?

    true
  end

  def filter_cells_with_same_color_pieces(cells)
    cells.select! { |cell| cell.value.nil? || cell.value.class.superclass.to_s == self.class.superclass.to_s }
  end

  def remove_moves_beyond_the_board(move_array)
    move_array.select! do |co_ord|
      co_ord[0] >= 0 && co_ord[1] >= 0
      co_ord[0] < 8 && co_ord[1] < 8
    end
  end

  def get_cells_from_move_array(move_array, board)
    cell_strings = move_array.map { |co_ord| board.get_cell_string_co_ord(co_ord) }
    cell_strings.map { |co_ord| board.get_cell(co_ord) }
  end
end
