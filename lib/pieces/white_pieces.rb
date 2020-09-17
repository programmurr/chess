# frozen_string_literal: true

require_relative 'piece'
require_relative 'moves'
require 'colorize'

class WhitePawn < Piece
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

class WhiteRook < Piece
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
    " \u2656 ".colorize(color: :black)
  end
end

class WhiteBishop < Piece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def display
    " \u2657 ".colorize(color: :black)
  end
end

class WhiteKnight < Piece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def display
    " \u2658 ".colorize(color: :black)
  end
end

class WhiteQueen < Piece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def display
    " \u2655 ".colorize(color: :black)
  end
end

class WhiteKing < Piece
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
    " \u2654 ".colorize(color: :black)
  end
end
