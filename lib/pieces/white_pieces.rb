# frozen_string_literal: true

require 'colorize'

# Consider making an overall Piece class. Move WhitePiece/BlackPiece methods into that
class WhitePiece
  attr_accessor :color
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def algebraic_name
    self.class.to_s.split(//).each.with_index do |letter, index|
      if ('A'..'Z').include?(letter) && !index.zero?
        return letter
      elsif is_a? WhiteKnight
        return 'N'
      end
    end
  end
end

class WhitePawn < WhitePiece
  def display
    " \u2659 ".colorize(color: :black)
  end
end

class WhiteRook < WhitePiece
  def display
    " \u2656 ".colorize(color: :black)
  end

  def initial_co_ords
    %w[a1 h1]
  end
end

class WhiteBishop < WhitePiece
  def display
    " \u2657 ".colorize(color: :black)
  end

  def initial_co_ords
    %w[c1 f1]
  end
end

class WhiteKnight < WhitePiece
  def display
    " \u2658 ".colorize(color: :black)
  end

  def initial_co_ords
    %w[b1 g1]
  end
end

class WhiteQueen < WhitePiece
  def display
    " \u2655 ".colorize(color: :black)
  end

  def initial_co_ords
    'd1'
  end
end

class WhiteKing < WhitePiece
  def display
    " \u2654 ".colorize(color: :black)
  end

  def initial_co_ords
    'e1'
  end
end
