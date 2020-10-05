# frozen_string_literal: false

require 'pry'
require 'colorize'
require_relative 'piece'

# Represents an 8x8 chess board. Responsible for displaying and setting itself up
#   and retrieving information from cells
class Board
  Cell = Struct.new(:co_ord, :value)

  attr_accessor :grid

  def initialize(grid: default_grid)
    @grid = grid
  end

  def setup
    set_cell_coordinates
    place_pawns
    place_royalty
  end

  def adjascent_cells_from_current_position(co_ord)
    array_co_ord = grid_coordinate_map.fetch(co_ord)
    x = array_co_ord[0]
    y = array_co_ord[1]
    [grid_coordinate_array_map.fetch([x, y - 1]), grid_coordinate_array_map.fetch([x, y + 1])]
  end

  def get_castle_cells(co_ord)
    { 'a1' => [grid[7][0], grid[7][1], grid[7][2], grid[7][3], grid[7][4]],
      'a8' => [grid[0][0], grid[0][1], grid[0][2], grid[0][3], grid[0][4]],
      'h1' => [grid[7][4], grid[7][5], grid[7][6], grid[7][7]],
      'h8' => [grid[0][4], grid[0][5], grid[0][6], grid[0][7]] }.fetch(co_ord)
  end

  def get_cell(co_ord)
    grid_coordinate_cell_map.fetch(co_ord)
  end

  def get_cell_from_array_co_ord(co_ord)
    grid_coordinate_array_map.fetch(co_ord)
  end

  def get_cell_grid_co_ord(co_ord)
    grid_coordinate_map.fetch(co_ord)
  end

  def get_cell_string_co_ord(co_ord)
    grid_coordinate_map.key(co_ord)
  end

  def get_cells_from_array(moves)
    moves.map { |move| grid_coordinate_array_map.fetch(move) }
  end

  def get_cells_from_hash(moves)
    moves.each_value do |positions|
      positions.map! { |co_ord| get_cell_string_co_ord(co_ord) }
      positions.map! { |co_ord| get_cell(co_ord) }
    end
  end

  def place_royalty
    place_black_royalty
    place_white_royalty
  end

  def place_pawns
    grid[6].each { |cell| cell.value = WhitePawn.new('White') }
    grid[1].each { |cell| cell.value = BlackPawn.new('Black') }
  end

  def set_cell_coordinates
    set_columns
    set_rows
  end

  def display
    row_numbers = %w[8 7 6 5 4 3 2 1]
    puts '   a  b  c  d  e  f  g  h '
    grid.each do |row|
      current_row = row_numbers.shift
      puts "#{current_row} ".concat(
        row.map do |cell|
          display_checks(cell)
        end.join('')
      ).concat(" #{current_row}")
    end
    puts '   a  b  c  d  e  f  g  h '
  end

  def execute_a1_castle
    grid[7][3].value = grid[7][0].value
    grid[7][0].value = nil
    grid[7][3].value.number_of_moves = 1
    grid[7][2].value = grid[7][4].value
    grid[7][4].value = nil
    grid[7][2].value.number_of_moves = 1
  end

  def execute_a8_castle
    grid[0][3].value = grid[0][0].value
    grid[0][0].value = nil
    grid[0][3].value.number_of_moves = 1
    grid[0][2].value = grid[0][4].value
    grid[0][4].value = nil
    grid[0][2].value.number_of_moves = 1
  end

  def execute_h1_castle
    grid[7][5].value = grid[7][7].value
    grid[7][7].value = nil
    grid[7][5].value.number_of_moves = 1
    grid[7][6].value = grid[7][4].value
    grid[7][4].value = nil
    grid[7][6].value.number_of_moves = 1
  end

  def execute_h8_castle
    grid[0][5].value = grid[0][7].value
    grid[0][7].value = nil
    grid[0][5].value.number_of_moves = 1
    grid[0][6].value = grid[0][4].value
    grid[0][4].value = nil
    grid[0][6].value.number_of_moves = 1
  end

  def grid_coordinate_map
    { 'a8' => [0, 0], 'b8' => [0, 1], 'c8' => [0, 2], 'd8' => [0, 3], 'e8' => [0, 4], 'f8' => [0, 5], 'g8' => [0, 6], 'h8' => [0, 7],
      'a7' => [1, 0], 'b7' => [1, 1], 'c7' => [1, 2], 'd7' => [1, 3], 'e7' => [1, 4], 'f7' => [1, 5], 'g7' => [1, 6], 'h7' => [1, 7],
      'a6' => [2, 0], 'b6' => [2, 1], 'c6' => [2, 2], 'd6' => [2, 3], 'e6' => [2, 4], 'f6' => [2, 5], 'g6' => [2, 6], 'h6' => [2, 7],
      'a5' => [3, 0], 'b5' => [3, 1], 'c5' => [3, 2], 'd5' => [3, 3], 'e5' => [3, 4], 'f5' => [3, 5], 'g5' => [3, 6], 'h5' => [3, 7],
      'a4' => [4, 0], 'b4' => [4, 1], 'c4' => [4, 2], 'd4' => [4, 3], 'e4' => [4, 4], 'f4' => [4, 5], 'g4' => [4, 6], 'h4' => [4, 7],
      'a3' => [5, 0], 'b3' => [5, 1], 'c3' => [5, 2], 'd3' => [5, 3], 'e3' => [5, 4], 'f3' => [5, 5], 'g3' => [5, 6], 'h3' => [5, 7],
      'a2' => [6, 0], 'b2' => [6, 1], 'c2' => [6, 2], 'd2' => [6, 3], 'e2' => [6, 4], 'f2' => [6, 5], 'g2' => [6, 6], 'h2' => [6, 7],
      'a1' => [7, 0], 'b1' => [7, 1], 'c1' => [7, 2], 'd1' => [7, 3], 'e1' => [7, 4], 'f1' => [7, 5], 'g1' => [7, 6], 'h1' => [7, 7] }
  end

  private

  # 9/14 - HACK: I know this is awful, just please bear with me until I can refactor
  def grid_coordinate_cell_map
    { 'a8' => grid[0][0], 'b8' => grid[0][1], 'c8' => grid[0][2], 'd8' => grid[0][3], 'e8' => grid[0][4], 'f8' => grid[0][5], 'g8' => grid[0][6], 'h8' => grid[0][7],
      'a7' => grid[1][0], 'b7' => grid[1][1], 'c7' => grid[1][2], 'd7' => grid[1][3], 'e7' => grid[1][4], 'f7' => grid[1][5], 'g7' => grid[1][6], 'h7' => grid[1][7],
      'a6' => grid[2][0], 'b6' => grid[2][1], 'c6' => grid[2][2], 'd6' => grid[2][3], 'e6' => grid[2][4], 'f6' => grid[2][5], 'g6' => grid[2][6], 'h6' => grid[2][7],
      'a5' => grid[3][0], 'b5' => grid[3][1], 'c5' => grid[3][2], 'd5' => grid[3][3], 'e5' => grid[3][4], 'f5' => grid[3][5], 'g5' => grid[3][6], 'h5' => grid[3][7],
      'a4' => grid[4][0], 'b4' => grid[4][1], 'c4' => grid[4][2], 'd4' => grid[4][3], 'e4' => grid[4][4], 'f4' => grid[4][5], 'g4' => grid[4][6], 'h4' => grid[4][7],
      'a3' => grid[5][0], 'b3' => grid[5][1], 'c3' => grid[5][2], 'd3' => grid[5][3], 'e3' => grid[5][4], 'f3' => grid[5][5], 'g3' => grid[5][6], 'h3' => grid[5][7],
      'a2' => grid[6][0], 'b2' => grid[6][1], 'c2' => grid[6][2], 'd2' => grid[6][3], 'e2' => grid[6][4], 'f2' => grid[6][5], 'g2' => grid[6][6], 'h2' => grid[6][7],
      'a1' => grid[7][0], 'b1' => grid[7][1], 'c1' => grid[7][2], 'd1' => grid[7][3], 'e1' => grid[7][4], 'f1' => grid[7][5], 'g1' => grid[7][6], 'h1' => grid[7][7] }
  end

  # 9/14 - HACK: Please see comment above

  def grid_coordinate_array_map
    { [0, 0] => grid[0][0], [0, 1] => grid[0][1], [0, 2] => grid[0][2], [0, 3] => grid[0][3], [0, 4] => grid[0][4], [0, 5] => grid[0][5], [0, 6] => grid[0][6], [0, 7] => grid[0][7],
      [1, 0] => grid[1][0], [1, 1] => grid[1][1], [1, 2] => grid[1][2], [1, 3] => grid[1][3], [1, 4] => grid[1][4], [1, 5] => grid[1][5], [1, 6] => grid[1][6], [1, 7] => grid[1][7],
      [2, 0] => grid[2][0], [2, 1] => grid[2][1], [2, 2] => grid[2][2], [2, 3] => grid[2][3], [2, 4] => grid[2][4], [2, 5] => grid[2][5], [2, 6] => grid[2][6], [2, 7] => grid[2][7],
      [3, 0] => grid[3][0], [3, 1] => grid[3][1], [3, 2] => grid[3][2], [3, 3] => grid[3][3], [3, 4] => grid[3][4], [3, 5] => grid[3][5], [3, 6] => grid[3][6], [3, 7] => grid[3][7],
      [4, 0] => grid[4][0], [4, 1] => grid[4][1], [4, 2] => grid[4][2], [4, 3] => grid[4][3], [4, 4] => grid[4][4], [4, 5] => grid[4][5], [4, 6] => grid[4][6], [4, 7] => grid[4][7],
      [5, 0] => grid[5][0], [5, 1] => grid[5][1], [5, 2] => grid[5][2], [5, 3] => grid[5][3], [5, 4] => grid[5][4], [5, 5] => grid[5][5], [5, 6] => grid[5][6], [5, 7] => grid[5][7],
      [6, 0] => grid[6][0], [6, 1] => grid[6][1], [6, 2] => grid[6][2], [6, 3] => grid[6][3], [6, 4] => grid[6][4], [6, 5] => grid[6][5], [6, 6] => grid[6][6], [6, 7] => grid[6][7],
      [7, 0] => grid[7][0], [7, 1] => grid[7][1], [7, 2] => grid[7][2], [7, 3] => grid[7][3], [7, 4] => grid[7][4], [7, 5] => grid[7][5], [7, 6] => grid[7][6], [7, 7] => grid[7][7] }
  end

  # HACK: DRY it up
  def white_cells
    [grid[0][0], grid[0][2], grid[0][4], grid[0][6],
     grid[1][1], grid[1][3], grid[1][5], grid[1][7],
     grid[2][0], grid[2][2], grid[2][4], grid[2][6],
     grid[3][1], grid[3][3], grid[3][5], grid[3][7],
     grid[4][0], grid[4][2], grid[4][4], grid[4][6],
     grid[5][1], grid[5][3], grid[5][5], grid[5][7],
     grid[6][0], grid[6][2], grid[6][4], grid[6][6],
     grid[7][1], grid[7][3], grid[7][5], grid[7][7]]
  end

  def display_checks(cell)
    if cell_has_a_piece_and_tile_is_white?(cell)
      display_piece_on_white_tile(cell)
    elsif cell_has_a_piece_and_tile_is_black?(cell)
      display_piece_on_black_tile(cell)
    elsif cell_is_empty_and_tile_is_white?(cell)
      display_empty_white_tile
    else
      display_empty_black_tile
    end
  end

  def display_empty_black_tile
    '   '.colorize(background: :light_black)
  end

  def display_empty_white_tile
    '   '.colorize(background: :light_white)
  end

  def cell_is_empty_and_tile_is_white?(cell)
    cell.value.nil? && white_cells.include?(cell)
  end

  def display_piece_on_black_tile(cell)
    cell.value.display_on_board.to_s.colorize(background: :light_black)
  end

  def cell_has_a_piece_and_tile_is_black?(cell)
    return true if cell.value
  end

  def display_piece_on_white_tile(cell)
    cell.value.display_on_board.to_s.colorize(background: :light_white)
  end

  def cell_has_a_piece_and_tile_is_white?(cell)
    return true if cell.value && white_cells.include?(cell)
  end

  def place_black_royalty
    royalty = [Rook.new('Black'), Knight.new('Black'), Bishop.new('Black'), Queen.new('Black'), King.new('Black'), Bishop.new('Black'), Knight.new('Black'), Rook.new('Black')]
    grid[0].map { |cell| cell.value = royalty.shift }
  end

  def place_white_royalty
    royalty = [Rook.new('White'), Knight.new('White'), Bishop.new('White'), Queen.new('White'), King.new('White'), Bishop.new('White'), Knight.new('White'), Rook.new('White')]
    grid[7].map { |cell| cell.value = royalty.shift }
  end

  def set_columns
    grid.each do |row|
      letters = %w[a b c d e f g h]
      row.each do |cell|
        current_letter = letters.shift
        cell.co_ord = [current_letter]
      end
    end
  end

  def set_rows
    numbers = %w[8 7 6 5 4 3 2 1]
    grid.each do |row|
      current_number = numbers.shift
      row.each do |cell|
        cell.co_ord << current_number
        cell.co_ord = cell.co_ord.join
      end
    end
  end

  def default_grid
    Array.new(8) { Array.new(8) { Cell.new } }
  end
end
