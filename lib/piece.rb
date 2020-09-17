# frozen_string_literal: true

require_relative 'moves'

class Piece
  attr_accessor :color, :first_move
  def initialize(color)
    @color = color
    @first_move = true
  end

  def name
    self.class.to_s
  end
end

class Pawn < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    if color == 'White'
      " \u2659 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265F ".colorize(color: :black)
    end
  end
end

class BlackPawn < Piece
  def initialize
    @color = 'Black'
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    " \u265F ".colorize(color: :black)
  end
end

class WhitePawn < Piece
  def initialize
    @color = 'White'
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    " \u2659 ".colorize(color: :black)
  end
end

class Rook < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    if color == 'White'
      " \u2656 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265C ".colorize(color: :black)
    end
  end
end

class Bishop < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def display
    if color == 'White'
      " \u2657 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265D ".colorize(color: :black)
    end
  end
end

class Knight < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def display
    if color == 'White'
      " \u2658 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265E ".colorize(color: :black)
    end
  end
end

class Queen < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def display
    if color == 'White'
      " \u2655 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265B ".colorize(color: :black)
    end
  end
end

class King < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    if color == 'White'
      " \u2654 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265A ".colorize(color: :black)
    end
  end
end