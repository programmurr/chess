# frozen_string_literal: true

require_relative 'piece'
require_relative 'moves'
require 'colorize'

class BlackPiece < Piece
  attr_accessor :color
  def initialize
    @color = 'Black'
  end
end

class BlackPawn < BlackPiece
  def initialize
    @color = 'Black'
  end

  def name
    self.class.to_s
  end

  def display
    " \u265F ".colorize(color: :black)
  end
end

class BlackRook < BlackPiece
  def initialize
    @color = 'Black'
  end

  def name
    self.class.to_s
  end

  def display
    " \u265C ".colorize(color: :black)
  end

  def initial_co_ords
    %w[a8 h8]
  end
end

class BlackBishop < BlackPiece
  def initialize
    @color = 'Black'
  end

  def name
    self.class.to_s
  end

  def display
    " \u265D ".colorize(color: :black)
  end

  def initial_co_ords
    %w[c8 f8]
  end
end

class BlackKnight < BlackPiece
  def initialize
    @color = 'Black'
  end

  def name
    self.class.to_s
  end

  def display
    " \u265E ".colorize(color: :black)
  end

  def initial_co_ords
    %w[b8 g8]
  end
end

class BlackQueen < BlackPiece
  def initialize
    @color = 'Black'
  end

  def name
    self.class.to_s
  end

  def display
    " \u265B ".colorize(color: :black)
  end

  def initial_co_ords
    'd8'
  end
end

class BlackKing < BlackPiece
  def initialize
    @color = 'Black'
  end

  def name
    self.class.to_s
  end

  def display
    " \u265A ".colorize(color: :black)
  end

  def initial_co_ords
    'e8'
  end
end
