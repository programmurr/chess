# frozen_string_literal: true

require_relative 'white_pieces'
require_relative 'black_pieces'

class Piece
  attr_accessor :color, :first_move
  def initialize(color)
    @color = color
    @first_move = true
  end

  def name
    "#{color}Piece"
  end

  def algebraic_name
    self.class.to_s.split(//).each.with_index do |letter, index|
      if ('A'..'Z').include?(letter) && !index.zero?
        return letter
      elsif is_a? WhiteKnight
        return 'N'
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
    moves_hash = { 'WhitePawn' => Moves.white_pawn(co_ord),
                   'BlackPawn' => Moves.black_pawn(co_ord),
                   'Rook' => Moves.rook(co_ord),
                   'Bishop' => Moves.bishop(co_ord),
                   'Knight' => Moves.knight(co_ord),
                   'Queen' => Moves.queen(co_ord),
                   'King' => Moves.king(co_ord) }
    moves_hash.fetch(class_name)
  end
end
