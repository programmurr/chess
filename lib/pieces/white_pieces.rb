# frozen_string_literal: true

require_relative 'piece'
require_relative 'moves'
require 'colorize'

class WhitePiece < Piece
  attr_accessor :color
  def initialize
    @color = 'White'
  end
end

class WhitePawn < WhitePiece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    " \u2659 ".colorize(color: :black)
  end
end

class WhiteRook < WhitePiece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def first_move?
    return true if first_move == true

    false
  end

  def self.moves(co_ord)
    co_ord
  end

  def display
    " \u2656 ".colorize(color: :black)
  end

  def initial_co_ords
    %w[a1 h1]
  end
end

class WhiteBishop < WhitePiece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def self.moves(co_ord)
    co_ord
  end

  def display
    " \u2657 ".colorize(color: :black)
  end

  def initial_co_ords
    %w[c1 f1]
  end
end

class WhiteKnight < WhitePiece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def display
    " \u2658 ".colorize(color: :black)
  end

  def initial_co_ords
    %w[b1 g1]
  end
end

class WhiteQueen < WhitePiece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def self.moves(co_ord)
    co_ord
  end

  def display
    " \u2655 ".colorize(color: :black)
  end

  def initial_co_ords
    'd1'
  end
end

class WhiteKing < WhitePiece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def first_move?
    return true if first_move == true

    false
  end

  def self.moves(co_ord)
    co_ord
  end

  def display
    " \u2654 ".colorize(color: :black)
  end

  def initial_co_ords
    'e1'
  end
end
