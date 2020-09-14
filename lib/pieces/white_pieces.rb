# frozen_string_literal: true

require 'colorize'
# require_relative 'valid_moves'

# Consider making an overall Piece class. Move WhitePiece/BlackPiece methods into that
# 9/14 - This will need refactoring later but I don't know into what, yet
# Follow where the yellow brick goes goes for now in terms of generating moves
# Then revisit. YAGNI
class WhitePiece
  attr_accessor :color, :first_move
  def initialize
    @color = 'White'
    @first_move = true
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

  def valid_moves(co_ord)
    moves_hash = { 'WhitePawn' => WhitePawn.moves(co_ord),
                   'WhiteRook' => WhiteRook.moves(co_ord),
                   'WhiteBishop' => WhiteBishop.moves(co_ord),
                   'WhiteKnight' => WhiteKnight.moves(co_ord),
                   'WhiteQueen' => WhiteQueen.moves(co_ord),
                   'WhiteKing' => WhiteKing.moves(co_ord) }
    moves_hash.fetch(self.class.name)
    # ValidMoves.moves(self.class.name, co_ord)
  end
end

class WhitePawn < WhitePiece
  def first_move?
    return true if first_move == true

    false
  end

  def moves(co_ord)
    # co_ord == b2 / grid[6][1]
    # possible moves from here:
    # - grid[5][1] - unless a piece is blocking it
    # - grid[x-1][y]
    # - grid[4][1] - if first move / unless a piece is blocking it
    # - grid[x-2][y]
    # - grid[5][0] - if enemy piece on it
    # - grid[x-1][y-1]
    # - grid[5][2] - if enemy piece on it
    # - grid[x-1][y+1]
  end

  def display
    " \u2659 ".colorize(color: :black)
  end
end

class WhiteRook < WhitePiece
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
  def self.moves(co_ord)
    co_ord
  end

  def display
    " \u2658 ".colorize(color: :black)
  end

  def initial_co_ords
    %w[b1 g1]
  end
end

class WhiteQueen < WhitePiece
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

pawn = WhitePawn.new
pawn.moves('b2')
