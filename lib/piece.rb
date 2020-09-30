# frozen_string_literal: true

require 'colorize'
require_relative 'moves'

# Remove color attribute for Piece? Is not cascading to subclasses, and causes trouble
#   Not really useful for the player either
class Piece
  attr_accessor :color, :first_move, :number_of_moves
  def initialize(color)
    @color = color
    @first_move = true
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

  def first_move?
    return true if first_move == true

    false
  end

  def all_move_coordinates_from_current_position(co_ord)
    self.class.moves(co_ord)
  end
end

class WhitePawn < Piece
  def self.moves(co_ord)
    if START_CO_ORDS.include?(co_ord)
      WhitePawnMoves.new(co_ord).first_moves
    else
      WhitePawnMoves.new(co_ord).moves
    end
  end

  START_CO_ORDS = [[6, 0], [6, 1], [6, 2], [6, 3], [6, 4], [6, 5], [6, 6], [6, 7]].freeze

  attr_reader :color, :number_of_moves

  def initialize(color)
    @number_of_moves = 0
    @color = color
  end

  def display_on_board
    " \u2659 ".colorize(color: :black)
  end

  def display_for_capture
    " \u265F ".colorize(color: :light_white)
  end

  def move_filter(cells, _end_co_ord)
    unless cells['up_right'].empty?
      cells['up_right'] = [] if cells['up_right'][0].value.nil?
    end
    unless cells['up_left'].empty?
      cells['up_left'] = [] if cells['up_left'][0].value.nil?
    end
    unless cells['up'].empty?
      cells['up'] = [] unless cells['up'][0].value.nil?
    end
    unless cells['double_up'].empty?
      cells['double_up'] = [] unless cells['double_up'][0].value.nil?
    end
    cells
  end

  def valid_move?(cells, end_co_ord)
    cells.each_value do |move|
      move.each do |position|
        return true if end_co_ord == position.co_ord
      end
    end
    false
  end

  def special_moves
    # En passant - if pawn in adjascent left/right just completed a first move
    # Promotion
  end
end

class BlackPawn < Piece
  def self.moves(co_ord)
    if START_CO_ORDS.include?(co_ord)
      BlackPawnMoves.new(co_ord).first_moves
    else
      BlackPawnMoves.new(co_ord).moves
    end
  end

  START_CO_ORDS = [[1, 0], [1, 1], [1, 2], [1, 3], [1, 4], [1, 5], [1, 6], [1, 7]].freeze

  attr_reader :color, :number_of_moves

  def initialize(color)
    @color = color
    @number_of_moves = 0
  end

  def display_on_board
    " \u265F ".colorize(color: :black)
  end

  def display_for_capture
    " \u265F ".colorize(color: :white)
  end

  def move_filter(cells, _end_co_ord)
    unless cells['down'].empty?
      cells['down'] = [] unless cells['down'][0].value.nil?
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

  def valid_move?(cells, end_co_ord)
    cells.each_value do |move|
      move.each do |position|
        return true if end_co_ord == position.co_ord
      end
    end
    false
  end

  def special_moves
    # En passant - if pawn in adjascent left/right just completed a first move
    # Promotion
  end
end

class Rook < Piece
  def self.moves(co_ord)
    RookMoves.new(co_ord).moves
  end

  attr_reader :color
  attr_accessor :first_move, :number_of_moves

  def initialize(color)
    @color = color
    @first_move = true
    @number_of_moves = 0
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

  def special_moves
    # Castle h1
    # Castle h8
    # Castle a1
    # Castle a8
  end
end

class Bishop < Piece
  def self.moves(co_ord)
    BishopMoves.new(co_ord).moves
  end

  attr_reader :color, :number_of_moves

  def initialize(color)
    @color = color
    @number_of_moves = 0
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

class Knight < Piece
  def self.moves(co_ord)
    KnightMoves.new(co_ord).moves
  end

  attr_reader :color, :number_of_moves

  def initialize(color)
    @color = color
    @number_of_moves = 0
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

  def move_filter(cells, _end_co_ord)
    return if cells.length.zero?

    cells.select! { |cell| cell.value.nil? }
  end

  def valid_move?(cells, _end_co_ord)
    return false if cells.length.zero?

    true
  end
end

class Queen < Piece
  def self.moves(co_ord)
    RookMoves.new(co_ord).moves.merge(BishopMoves.new(co_ord).moves)
  end

  attr_reader :color, :number_of_moves

  def initialize(color)
    @color = color
    @number_of_moves = 0
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

class King < Piece
  def self.moves(co_ord)
    KingMoves.new(co_ord).moves
  end

  attr_reader :color
  attr_accessor :first_move, :number_of_moves

  def initialize(color)
    @color = color
    @first_move = true
    @number_of_moves = 0
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

  def special_moves
    # Castle h1
    # Castle h8
    # Castle a1
    # Castle a8
  end
end
