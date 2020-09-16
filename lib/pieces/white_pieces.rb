# frozen_string_literal: true

# require_relative 'piece'
require_relative 'moves'
require 'colorize'
# require_relative 'valid_moves'

# Consider making an overall Piece class. Move WhitePiece/BlackPiece methods into that
# 9/14 - This will need refactoring later but I don't know into what, yet
# Follow where the yellow brick goes goes for now in terms of generating moves
# Then revisit. YAGNI
class WhitePiece # < Piece
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

  # Moves class
  def valid_moves(co_ord, class_name)
    # FIXME: This currently generates ALL moves for all piece classes from that co-ord
    #   Fetch is only returning the specific array requested
    #   So if there's an error in Moves.rook, Moves.bishop will never activate
    #   Check out 99 Bottles OOP I think she did a work-around for this
    moves_hash = { 'WhitePawn' => Moves.white_pawn(co_ord),
                   'WhiteRook' => Moves.rook(co_ord),
                   'WhiteBishop' => Moves.bishop(co_ord),
                   'WhiteKnight' => Moves.knight(co_ord),
                   'WhiteQueen' => Moves.queen(co_ord),
                   'WhiteKing' => Moves.king(co_ord) }
    moves_hash.fetch(class_name)
  end
end

class WhitePawn < WhitePiece
  def first_move?
    return true if first_move == true

    false
  end

  def display
    " \u2659 ".colorize(color: :black)
  end
end

class WhiteRook < WhitePiece
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
