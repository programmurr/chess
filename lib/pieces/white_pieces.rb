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

  def valid_moves(co_ord, class_name)
    moves_hash = { 'WhitePawn' => WhitePawn.moves(co_ord),
                   'WhiteRook' => WhiteRook.moves(co_ord),
                   'WhiteBishop' => WhiteBishop.moves(co_ord),
                   'WhiteKnight' => WhiteKnight.moves(co_ord),
                   'WhiteQueen' => WhiteQueen.moves(co_ord),
                   'WhiteKing' => WhiteKing.moves(co_ord) }
    moves_hash.fetch(class_name)
  end
end

class WhitePawn < WhitePiece
  def first_move?
    return true if first_move == true

    false
  end

  # 9/14 - Look back at connect4 to improve this
  # 9/15 - Pawns are more complicated than I thought
  # 9/15 - Get the moves for other pieces like knights, rooks, etc. then come back to this
  def self.moves(co_ord)
    x = co_ord[0]
    y = co_ord[1]
    move_array = []
    move1 =  [x - 1, y]
    move2 =  [x - 2, y]
    move3 =  [x - 1, y - 1] # attack move
    move4 =  [x - 1, y + 1] # attack move
    move_array << move1
    move_array << move2
    move_array << move3
    move_array << move4
    move_array
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
  MOVES_LIST = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

  def self.moves(co_ord)
    MOVES_LIST.map { |a, b| [co_ord.first + a, co_ord.last + b] }
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
