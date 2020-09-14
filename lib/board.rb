# frozen_string_literal: false

require 'pry'
require 'colorize'
require_relative 'cell'
require_relative 'pieces/white_pieces'
require_relative 'pieces/black_pieces'

class Board
  attr_accessor :grid

  def initialize(grid: default_grid)
    @grid = grid
  end

  def get_cell(co_ord)
    grid_coordinate_map.fetch(co_ord)
  end

  def get_cell_grid_co_ord(co_ord)
    grid_coordinate_array_map.fetch(co_ord)
  end

  # 9/14 - I know this is awful, just please bear with me until I can refactor
  def grid_coordinate_map
    { 'a8' => grid[0][0], 'b8' => grid[0][1], 'c8' => grid[0][2], 'd8' => grid[0][3], 'e8' => grid[0][4], 'f8' => grid[0][5], 'g8' => grid[0][6], 'h8' => grid[0][7],
      'a7' => grid[1][0], 'b7' => grid[1][1], 'c7' => grid[1][2], 'd7' => grid[1][3], 'e7' => grid[1][4], 'f7' => grid[1][5], 'g7' => grid[1][6], 'h7' => grid[1][7],
      'a6' => grid[2][0], 'b6' => grid[2][1], 'c6' => grid[2][2], 'd6' => grid[2][3], 'e6' => grid[2][4], 'f6' => grid[2][5], 'g6' => grid[2][6], 'h6' => grid[2][7],
      'a5' => grid[3][0], 'b5' => grid[3][1], 'c5' => grid[3][2], 'd5' => grid[3][3], 'e5' => grid[3][4], 'f5' => grid[3][5], 'g5' => grid[3][6], 'h5' => grid[3][7],
      'a4' => grid[4][0], 'b4' => grid[4][1], 'c4' => grid[4][2], 'd4' => grid[4][3], 'e4' => grid[4][4], 'f4' => grid[4][5], 'g4' => grid[4][6], 'h4' => grid[4][7],
      'a3' => grid[5][0], 'b3' => grid[5][1], 'c3' => grid[5][2], 'd3' => grid[5][3], 'e3' => grid[5][4], 'f3' => grid[5][5], 'g3' => grid[5][6], 'h3' => grid[5][7],
      'a2' => grid[6][0], 'b2' => grid[6][1], 'c2' => grid[6][2], 'd2' => grid[6][3], 'e2' => grid[6][4], 'f2' => grid[6][5], 'g2' => grid[6][6], 'h2' => grid[6][7],
      'a1' => grid[7][0], 'b1' => grid[7][1], 'c1' => grid[7][2], 'd1' => grid[7][3], 'e1' => grid[7][4], 'f1' => grid[7][5], 'g1' => grid[7][6], 'h1' => grid[7][7] }
  end

  # 9/14 - Please see comment on line 24
  def grid_coordinate_array_map
    { 'a8' => [0, 0], 'b8' => [0, 1], 'c8' => [0, 2], 'd8' => [0, 3], 'e8' => [0, 4], 'f8' => [0, 5], 'g8' => [0, 6], 'h8' => [0, 7],
      'a7' => [1, 0], 'b7' => [1, 1], 'c7' => [1, 2], 'd7' => [1, 3], 'e7' => [1, 4], 'f7' => [1, 5], 'g7' => [1, 6], 'h7' => [1, 7],
      'a6' => [2, 0], 'b6' => [2, 1], 'c6' => [2, 2], 'd6' => [2, 3], 'e6' => [2, 4], 'f6' => [2, 5], 'g6' => [2, 6], 'h6' => [2, 7],
      'a5' => [3, 0], 'b5' => [3, 1], 'c5' => [3, 2], 'd5' => [3, 3], 'e5' => [3, 4], 'f5' => [3, 5], 'g5' => [3, 6], 'h5' => [3, 7],
      'a4' => [4, 0], 'b4' => [4, 1], 'c4' => [4, 2], 'd4' => [4, 3], 'e4' => [4, 4], 'f4' => [4, 5], 'g4' => [4, 6], 'h4' => [4, 7],
      'a3' => [5, 0], 'b3' => [5, 1], 'c3' => [5, 2], 'd3' => [5, 3], 'e3' => [5, 4], 'f3' => [5, 5], 'g3' => [5, 6], 'h3' => [5, 7],
      'a2' => [6, 0], 'b2' => [6, 1], 'c2' => [6, 2], 'd2' => [6, 3], 'e2' => [6, 4], 'f2' => [6, 5], 'g2' => [6, 6], 'h2' => [6, 7],
      'a1' => [7, 0], 'b1' => [7, 1], 'c1' => [7, 2], 'd1' => [7, 3], 'e1' => [7, 4], 'f1' => [7, 5], 'g1' => [7, 6], 'h1' => [7, 7] }
  end

  # TODO: DRY
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

  def place_royalty
    place_black_royalty
    place_white_royalty
  end

  def place_pawns
    grid[6].each { |cell| cell.value = WhitePawn.new }
    grid[1].each { |cell| cell.value = BlackPawn.new }
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

  private

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
    cell.value.display.to_s.colorize(background: :light_black)
  end

  def cell_has_a_piece_and_tile_is_black?(cell)
    return true if cell.value
  end

  def display_piece_on_white_tile(cell)
    cell.value.display.to_s.colorize(background: :light_white)
  end

  def cell_has_a_piece_and_tile_is_white?(cell)
    return true if cell.value && white_cells.include?(cell)
  end

  def place_black_royalty
    royalty = [BlackRook.new, BlackKnight.new, BlackBishop.new, BlackQueen.new, BlackKing.new, BlackBishop.new, BlackKnight.new, BlackRook.new]
    grid[0].map { |cell| cell.value = royalty.shift }
  end

  def place_white_royalty
    royalty = [WhiteRook.new, WhiteKnight.new, WhiteBishop.new, WhiteQueen.new, WhiteKing.new, WhiteBishop.new, WhiteKnight.new, WhiteRook.new]
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

board = Board.new
board.set_cell_coordinates
board.place_pawns
board.place_royalty
# board.display
# binding.pry
p board.get_cell_grid_co_ord('c5')
