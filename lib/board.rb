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
    row_numbers = %w[1 2 3 4 5 6 7 8]
    puts '  a b c d e f g h '
    grid.each do |row|
      current_row = row_numbers.shift
      puts "#{current_row} " + row.map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ') + " #{current_row}"
    end
    puts '  a b c d e f g h '
  end

  private

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

# board = Board.new
# board.set_cell_coordinates
# board.place_pawns
# board.place_royalty
# board.display
String.color_samples

# white piece
puts " \u2654 ".colorize(color: :black, background: :light_white)
puts " \u2654 ".colorize(color: :black, background: :light_black)
# black piece
puts " \u265A ".colorize(color: :black, background: :light_white)
puts " \u265A ".colorize(color: :black, background: :light_black)
