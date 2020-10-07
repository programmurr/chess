# frozen_string_literal: true

require 'colorize'
require_relative 'moves'

# Superclass of the chess board pieces
#   Responsible for knowing colors and triggering calculations of moves for each subclass
class Piece
  attr_accessor :color, :number_of_moves

  def initialize(color)
    @color = color
    @number_of_moves = 0
  end

  # Problem here. Seems to work with rook but not bishop. Not sure about other classes
  def check_move_filter(cells)
    return_array = []
    cells.each_value do |moves|
      binding.pry
      next if moves.length.zero?

      moves.each.with_index do |cell, index|
        unless cell.value.nil?
          binding.pry
          moves.slice!(index..-1)
          return_array << moves
          next
        end
      end
    end
    return_array
  end

  def move_filter(cells, end_co_ord)
    cells.each_value do |positions|
      if positions.length.zero?
        next
      elsif positions[-1].co_ord != end_co_ord
        positions.pop until positions.length.zero? || positions[-1].co_ord == end_co_ord
      end
    end
  end

  def valid_move?(cells, end_co_ord)
    cells.each_value do |move|
      move.each do |position|
        return false if !position.value.nil? && position.co_ord != end_co_ord
        return true if end_co_ord == position.co_ord
      end
    end
    false
  end

  def name
    self.class.to_s
  end

  def all_move_coordinates_from_current_position(co_ord, color)
    self.class.moves(co_ord, color)
  end
end

# Represent pawns on a chess board
#   Responsible for displaying themselves and knowing where they can move
class Pawn < Piece
  def self.moves(co_ord, color)
    if color == 'White' && WHITE_START_CO_ORDS.include?(co_ord)
      WhitePawnMoves.new(co_ord).first_moves
    elsif color == 'Black' && BLACK_START_CO_ORDS.include?(co_ord)
      BlackPawnMoves.new(co_ord).first_moves
    elsif color == 'White'
      WhitePawnMoves.new(co_ord).moves
    elsif color == 'Black'
      BlackPawnMoves.new(co_ord).moves
    end
  end

  WHITE_START_CO_ORDS = [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]].freeze
  BLACK_START_CO_ORDS = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]].freeze

  attr_accessor :en_passant

  def initialize(color)
    super
    @en_passant = false
  end

  def display_on_board
    { 'White' => " \u2659 ".colorize(color: :black),
      'Black' => " \u265F ".colorize(color: :black) }.fetch(color)
  end

  def display_for_capture
    { 'White' => " \u265F ".colorize(color: :light_white),
      'Black' => " \u265F ".colorize(color: :white) }.fetch(color)
  end

  def check_move_filter(cells)
    if color == 'White'
      white_check_move_filter(cells)
    elsif color == 'Black'
      black_check_move_filter(cells)
    end
  end

  def move_filter(cells, _end_co_ord)
    if color == 'White'
      white_move_filter(cells)
    elsif color == 'Black'
      black_move_filter(cells)
    end
  end

  def valid_move?(cells, end_co_ord)
    cells.each_value do |move|
      move.each do |position|
        return true if end_co_ord == position.co_ord
      end
    end
    false
  end

  private

  def white_check_move_filter(cells)
    return_array = []
    cells['up'] = []
    cells['double_up'] = []
    return_array << cells['up_left'] unless cells['up_left'].empty?
    return_array << cells['up_right'] unless cells['up_right'].empty?
    return_array
  end

  def black_check_move_filter(cells)
    return_array = []
    cells['down'] = []
    cells['double_down'] = []
    return_array << cells['down_left'] unless cells['down_left'].empty?
    return_array << cells['down_right'] unless cells['down_right'].empty?
    return_array
  end

  def white_move_filter(cells)
    unless cells['up_right'].empty?
      cells['up_right'] = [] if cells['up_right'][0].value.nil?
    end
    unless cells['up_left'].empty?
      cells['up_left'] = [] if cells['up_left'][0].value.nil?
    end
    unless cells['up'].empty?
      cells['up'] = [] unless cells['up'][0].value.nil?
      cells['double_up'] = [] if cells['up'] == []
    end
    unless cells['double_up'].empty?
      cells['double_up'] = [] unless cells['double_up'][0].value.nil?
    end
    cells
  end

  def black_move_filter(cells)
    unless cells['down'].empty?
      cells['down'] = [] unless cells['down'][0].value.nil?
      cells['double_down'] = [] if cells['down'] == []
    end
    unless cells['double_down'].empty?
      cells['double_down'] = [] unless cells['double_down'][0].value.nil?
    end
    unless cells['down_right'].empty?
      cells['down_right'] = [] if cells['down_right'][0].value.nil?
    end
    unless cells['down_left'].empty?
      cells['down_left'] = [] if cells['down_left'][0].value.nil?
    end
    cells
  end
end

# Represent rooks on a chess board
#   Responsible for displaying themselves and where they can move
class Rook < Piece
  def self.moves(co_ord, _color)
    RookMoves.new(co_ord).moves
  end

  def display_on_board
    if color == 'White'
      " \u2656 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265C ".colorize(color: :black)
    end
  end

  def display_for_capture
    " \u265C ".colorize(color: :white)
  end
end

# Represent bishops on a chess board
#   Responsible for displaying themselves and where they can move
class Bishop < Piece
  def self.moves(co_ord, _color)
    BishopMoves.new(co_ord).moves
  end

  def display_on_board
    if color == 'White'
      " \u2657 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265D ".colorize(color: :black)
    end
  end

  def display_for_capture
    " \u265D ".colorize(color: :white)
  end
end

# Represent knights on a chess board
#   Responsible for displaying themselves and where they can move
class Knight < Piece
  def self.moves(co_ord, _color)
    KnightMoves.new(co_ord).moves
  end

  def display_on_board
    if color == 'White'
      " \u2658 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265E ".colorize(color: :black)
    end
  end

  def display_for_capture
    " \u265E ".colorize(color: :white)
  end

  def check_move_filter(cells)
    return if cells.length.zero?

    cells.select! { |cell| cell.value.nil? }
    cells
  end

  def move_filter(cells, _end_co_ord)
    return if cells.length.zero?

    cells.select! { |cell| cell.value.nil? }
  end

  def valid_move?(cells, _end_co_ord)
    return false if cells.length.zero?

    true
  end
end

# Represent queens on a chess board
#   Responsible for displaying themselves and where they can move
class Queen < Piece
  def self.moves(co_ord, _color)
    RookMoves.new(co_ord).moves.merge(BishopMoves.new(co_ord).moves)
  end

  def display_on_board
    if color == 'White'
      " \u2655 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265B ".colorize(color: :black)
    end
  end

  def display_for_capture
    " \u265B ".colorize(color: :white)
  end
end

# Represent kings on a chess board
#   Responsible for displaying themselves and where they can move
class King < Piece
  def self.moves(co_ord, _color)
    KingMoves.new(co_ord).moves
  end

  def display_on_board
    if color == 'White'
      " \u2654 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265A ".colorize(color: :black)
    end
  end

  def display_for_capture
    " \u265A ".colorize(color: :white)
  end
end

# A ghost of a pawn that allows en passant to take place
#   Once taken, they get converted to the according color of pawn to be displayed in the game
#   Also holds a reference to it's twin 'real' pawn to allow that pawn to be captured en passant
class InvisiblePawn
  attr_reader :color, :enemy_cell

  def initialize(enemy_cell, color)
    @enemy_cell = enemy_cell
    @color = color
  end

  def display_on_board
    " \u200C  "
  end

  def display_for_capture; end
end
