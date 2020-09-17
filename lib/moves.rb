require_relative 'move_formulas'

class Moves
  include MoveFormulas

  KNIGHT_MOVES_LIST = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

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
    move_array = valid_moves(start_co_ords, selected_piece_class_name)
    possible_moves = remove_moves_beyond_the_board(move_array)
    cells = get_cells_from_move_array(possible_moves, board)
    filter_cells_with_same_color_pieces(cells)
    return false if cells.length.zero?

    cells.select! { |cell| cell.co_ord == end_cell.co_ord }
    return false if cells.length.zero?

    true
  end

  private

  def valid_moves(co_ord, class_name)
    moves_hash = { 'Pawn' => pawn(co_ord),
                   'Rook' => rook(co_ord),
                   'Bishop' => bishop(co_ord),
                   'Knight' => knight(co_ord),
                   'Queen' => queen(co_ord),
                   'King' => king(co_ord) }
    moves_hash.fetch(class_name)
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

  def knight(co_ord)
    KNIGHT_MOVES_LIST.map { |a, b| [co_ord.first + a, co_ord.last + b] }
  end

  def rook(co_ord)
    return_array = []
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x - 1, y]
      x -= 1
    end
    x = co_ord[0]
    7.times do
      return_array << [x, y + 1]
      y += 1
    end
    y = co_ord[1]
    7.times do
      return_array << [x + 1, y]
      x += 1
    end
    x = co_ord[0]
    7.times do
      return_array << [x, y - 1]
      y -= 1
    end
    y = co_ord[1]
    return_array
  end

  def bishop(co_ord)
    return_array = []
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x - 1, y + 1]
      x -= 1
      y += 1
    end
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x + 1, y + 1]
      x += 1
      y += 1
    end
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x + 1, y - 1]
      x += 1
      y -= 1
    end
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x - 1, y - 1]
      x -= 1
      y -= 1
    end
    x = co_ord[0]
    y = co_ord[1]
    return_array
  end

  def queen(co_ord)
    rook(co_ord) + bishop(co_ord)
  end

  def king(co_ord)
    move_array = []
    x = co_ord[0]
    y = co_ord[1]
    move1 =  [x - 1, y]
    move2 =  [x - 1, y - 1]
    move3 =  [x - 1, y + 1]
    move4 =  [x, y + 1]
    move5 =  [x + 1, y + 1]
    move6 =  [x + 1, y]
    move7 =  [x + 1, y - 1]
    move8 =  [x, y - 1]
    move_array << move1
    move_array << move2
    move_array << move3
    move_array << move4
    move_array << move5
    move_array << move6
    move_array << move7
    move_array << move8
    move_array
  end

  def pawn(co_ord)
    # This might blow up
    if start_cell.value.color == 'White'
      white_pawn(co_ord)
    elsif start_cell.value.color == 'Black'
      black_pawn(co_ord)
    end
  end

  # 9/14 - HACK: Dry this up
  def white_pawn(co_ord)
    x = co_ord[0]
    y = co_ord[1]
    white_array = []
    white_move1 =  [x - 1, y]
    white_move2 =  [x - 2, y]
    white_move3 =  [x - 1, y - 1] # attack move
    white_move4 =  [x - 1, y + 1] # attack move
    white_array << white_move1
    white_array << white_move2
    white_array << white_move3
    white_array << white_move4
    white_array
  end

  def black_pawn(co_ord)
    x = co_ord[0]
    y = co_ord[1]
    black_array = []
    black_move1 =  [x + 1, y]
    black_move2 =  [x + 2, y]
    black_move3 =  [x + 1, y - 1] # attack move
    black_move4 =  [x + 1, y + 1] # attack move
    black_array << black_move1
    black_array << black_move2
    black_array << black_move3
    black_array << black_move4
    black_array
  end
end
