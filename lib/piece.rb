# frozen_string_literal: true

require 'colorize'
require_relative 'moves'

# Remove color attribute for Piece? Is not cascading to subclasses, and causes trouble
#   Not really useful for the player either
class Piece
  attr_accessor :color, :first_move
  def initialize(color)
    @color = color
    @first_move = true
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

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def display_on_board
    " \u2659 ".colorize(color: :black)
  end

  def display_for_capture
    " \u265F ".colorize(color: :white)
  end

  def special_moves
    # En passant - if pawn in adjascent left/right just completed a first move
    # Attacking - if bottom left or bottom right cells contain an enemy piece
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

  attr_reader :color

  def initialize(color)
    @color = color
  end

  def display_on_board
    " \u265F ".colorize(color: :black)
  end

  def display_for_capture
    " \u265F ".colorize(color: :white)
  end

  def special_moves
    # En passant - if pawn in adjascent left/right just completed a first move
    # Attacking - if bottom left or bottom right cells contain an enemy piece
  end
end

class Rook < Piece
  def self.moves(co_ord)
    RookMoves.new(co_ord).moves
  end

  attr_reader :color

  def initialize(color)
    @color = color
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
    # Castling
  end
end

class Bishop < Piece
  def self.moves(co_ord)
    BishopMoves.new(co_ord).moves
  end

  attr_reader :color

  def initialize(color)
    @color = color
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

  attr_reader :color

  def initialize(color)
    @color = color
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
end

class Queen < Piece
  def self.moves(co_ord)
    RookMoves.new(co_ord).moves.merge(BishopMoves.new(co_ord).moves)
  end

  attr_reader :color

  def initialize(color)
    @color = color
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

  def initialize(color)
    @color = color
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
    # Castling
  end
end
