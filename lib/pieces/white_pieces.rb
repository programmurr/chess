# frozen_string_literal: true

class WhitePiece
  attr_accessor :color
  def initialize
    @color = 'White'
  end
end

class WhitePawn < WhitePiece
  def name
    self.class.to_s
  end

  def display
    "\u2659"
  end
end

class WhiteRook < WhitePiece
  def name
    self.class.to_s
  end

  def display
    "\u2656"
  end
end

class WhiteBishop < WhitePiece
  def name
    self.class.to_s
  end

  def display
    "\u2657"
  end
end

class WhiteKnight < WhitePiece
  def name
    self.class.to_s
  end

  def display
    "\u2658"
  end
end

class WhiteQueen < WhitePiece
  def name
    self.class.to_s
  end

  def display
    "\u2655"
  end
end

class WhiteKing < WhitePiece
  def name
    self.class.to_s
  end

  def display
    "\u2654"
  end
end
