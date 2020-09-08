# frozen_string_literal: true

class BlackPiece
  attr_accessor :color
  def initialize
    @color = 'Black'
  end
end

class BlackPawn < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265F"
  end
end

class BlackRook < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265C"
  end

  def initial_co_ords
    %w[a8 h8]
  end
end

class BlackBishop < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265D"
  end

  def initial_co_ords
    %w[c8 f8]
  end
end

class BlackKnight < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265E"
  end

  def initial_co_ords
    %w[b8 g8]
  end
end

class BlackQueen < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265B"
  end

  def initial_co_ords
    'd8'
  end
end

class BlackKing < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265A"
  end

  def initial_co_ords
    'e8'
  end
end
