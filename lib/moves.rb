require 'hashdiff'
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

  def cells_between_start_and_end_cells(start_cell, end_cell)
    # graph/bfs?
  end

  # May split this into a method just for rooks, bishops and queens
  #   Make a separate method for the other pieces
  def valid_move?
    # Immediately return false if the end cell color is the same as the player's color
    selected_piece_class_name = start_cell.value.class.to_s
    total_moves = all_moves(start_co_ords, selected_piece_class_name)
    possible_moves = remove_moves_beyond_the_board(total_moves)
    cells = get_cells_from_possible_moves(possible_moves, board)
    cells_backup = Marshal.load(Marshal.dump(cells))
    filter_cells_with_pieces(cells)
    chopped_cells = chop_cells_blocked_by_a_piece(cells, cells_backup)
    if contains_end_cell?(chopped_cells, end_cell) == false
      return false
    elsif contains_end_cell?(chopped_cells, end_cell)
      return true
    end
    return false if cells.length.zero?

    cells.select! { |cell| cell.co_ord == end_cell.co_ord }
    return false if cells.length.zero?

    true
  end

  private

  # Works for hash, not arrays i.e. only for rook, bishop and queen
  def contains_end_cell?(chopped_cells, end_cell)
    chopped_cells.each do |key, value|
      return true if chopped_cells[key].include?(end_cell)
    end
    false
  end

  # Works for hash, not arrays i.e. only for rook, bishop and queen
  def chop_cells_blocked_by_a_piece(cells, cells_backup)
    return_hash = {}
    cells.each_key do |key|
      if cells[key].length == cells_backup[key].length
        return_hash[key] = cells[key]
      end
    end
    return_hash
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

  def filter_cells_from_hash(cells)
    cells.each_value do |positions|
      positions.select! { |cell| cell.value.nil? }
    end
  end

  def filter_cells_with_pieces(cells)
    if cells.class == Hash
      filter_cells_from_hash(cells)
    else
      cells.select! { |cell| cell.value.nil? }
    end
  end

  def remove_hash_moves_beyond_board(total_moves)
    possible_hash = {}
    total_moves.each_key { |key| possible_hash[key] = [] }
    total_moves.each do |direction, positions|
      positions.each do |co_ord|
        next unless co_ord[0] < 8 && co_ord[1] < 8

        possible_hash[direction] << co_ord if !co_ord[0].negative? && !co_ord[1].negative?
      end
    end
    possible_hash
  end

  def remove_moves_beyond_the_board(total_moves)
    if total_moves.class == Hash
      remove_hash_moves_beyond_board(total_moves)
    else
      possible_array = []
      total_moves.each do |co_ord|
        next unless co_ord[0] < 8 && co_ord[1] < 8

        possible_array << co_ord if !co_ord[0].negative? && !co_ord[1].negative?
      end
      possible_array
    end
  end

  def get_cells_from_hash(possible_moves, board)
    possible_moves.each_value do |positions|
      positions.map! { |co_ord| board.get_cell_string_co_ord(co_ord) }
      positions.map! { |co_ord| board.get_cell(co_ord) }
    end
  end

  def get_cells_from_possible_moves(possible_moves, board)
    if possible_moves.class == Hash
      get_cells_from_hash(possible_moves, board)
    else
      cell_strings = possible_moves.map { |co_ord| board.get_cell_string_co_ord(co_ord) }
      cell_strings.map { |co_ord| board.get_cell(co_ord) }
    end
  end
end
