# frozen_string_literal: false

require 'pry'
require_relative 'cell'

class Board
  attr_accessor :grid
  def initialize(grid: default_grid)
    @grid = grid
  end

  def set_cell_coordinates
    set_columns
    set_rows
  end

  private

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
