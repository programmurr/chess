# frozen_string_literal: true

# require_relative 'piece'
require_relative 'moves'
require 'colorize'
# Consider making an overall Piece class. Move WhitePiece/BlackPiece methods into that
# 9/14 - This will need refactoring later but I don't know into what, yet
# Follow where the yellow brick goes goes for now in terms of generating moves
# Then revisit. YAGNI
class BlackPiece
  attr_accessor :color, :first_move
  def initialize
    @color = 'Black'
    @first_move = true
  end

  def name
    self.class.to_s
  end

  def algebraic_name
    self.class.to_s.split(//).each.with_index do |letter, index|
      if ('A'..'Z').include?(letter) && !index.zero?
        return letter
      elsif is_a? BlackKnight
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
    moves_hash = { 'BlackPawn' => Moves.black_pawn(co_ord),
                   'BlackRook' => Moves.rook(co_ord),
                   'BlackBishop' => Moves.bishop(co_ord),
                   'BlackKnight' => Moves.knight(co_ord),
                   'BlackQueen' => Moves.queen(co_ord),
                   'BlackKing' => Moves.king(co_ord) }
    moves_hash.fetch(class_name)
  end
end

class BlackPawn < BlackPiece
  def display
    " \u265F ".colorize(color: :black)
  end
end

class BlackRook < BlackPiece
  def display
    " \u265C ".colorize(color: :black)
  end

  def initial_co_ords
    %w[a8 h8]
  end
end

class BlackBishop < BlackPiece
  def display
    " \u265D ".colorize(color: :black)
  end

  def initial_co_ords
    %w[c8 f8]
  end
end

class BlackKnight < BlackPiece
  def display
    " \u265E ".colorize(color: :black)
  end

  def initial_co_ords
    %w[b8 g8]
  end
end

class BlackQueen < BlackPiece
  def display
    " \u265B ".colorize(color: :black)
  end

  def initial_co_ords
    'd8'
  end
end

class BlackKing < BlackPiece
  def display
    " \u265A ".colorize(color: :black)
  end

  def initial_co_ords
    'e8'
  end
end
