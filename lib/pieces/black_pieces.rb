# frozen_string_literal: true

require_relative 'piece'
require_relative 'moves'
require 'colorize'

class BlackPawn < Piece
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

class BlackRook < Piece
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

class BlackBishop < Piece
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

class BlackKnight < Piece
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

class BlackQueen < Piece
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

class BlackKing < Piece
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
