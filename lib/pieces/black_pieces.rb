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
end

class BlackBishop < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265D"
  end
end

class BlackKnight < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265E"
  end
end

class BlackQueen < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265B"
  end
end

class BlackKing < BlackPiece
  def name
    self.class.to_s
  end

  def display
    "\u265A"
  end
end
