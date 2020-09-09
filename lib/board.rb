# frozen_string_literal: false

require 'pry'
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

  # TODO: - Make it DRY
  def display
    puts '  a b c d e f g h '
    print '1 '
    puts grid[0].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 1')
    print '2 '
    puts grid[1].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 2')
    print '3 '
    puts grid[2].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 3')
    print '4 '
    puts grid[3].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 4')
    print '5 '
    puts grid[4].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 5')
    print '6 '
    puts grid[5].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 6')
    print '7 '
    puts grid[6].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 7')
    print '8 '
    puts grid[7].map { |cell| cell.value ? cell.value.display.to_s : '-' }.join(' ').concat(' 8')
    puts '  a b c d e f g h '
  end

  private

  # TODO: - Make it DRY
  def place_black_royalty
    grid[0][0].value = BlackRook.new
    grid[0][1].value = BlackKnight.new
    grid[0][2].value = BlackBishop.new
    grid[0][3].value = BlackQueen.new
    grid[0][4].value = BlackKing.new
    grid[0][5].value = BlackBishop.new
    grid[0][6].value = BlackKnight.new
    grid[0][7].value = BlackRook.new
  end

  # TODO: - Make it DRY
  def place_white_royalty
    grid[7][0].value = WhiteRook.new
    grid[7][1].value = WhiteKnight.new
    grid[7][2].value = WhiteBishop.new
    grid[7][3].value = WhiteQueen.new
    grid[7][4].value = WhiteKing.new
    grid[7][5].value = WhiteBishop.new
    grid[7][6].value = WhiteKnight.new
    grid[7][7].value = WhiteRook.new
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
board.display

# google how to test array elements in rspec
