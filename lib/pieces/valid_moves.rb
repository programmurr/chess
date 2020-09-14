require 'pry'

# 9/14 - I don't think I need this class any more. Will keep for now just in case
class ValidMoves
  def self.moves(class_name, co_ord)
    moves_hash = { 'WhitePawn' => white_pawn_moves(co_ord),
                   'WhiteRook' => white_rook_moves(co_ord),
                   'WhiteBishop' => white_bishop_moves(co_ord),
                   'WhiteKnight' => white_knight_moves(co_ord),
                   'WhiteQueen' => white_queen_moves(co_ord),
                   'WhiteKing' => white_king_moves(co_ord) }
    moves_hash.fetch(class_name)
  end

  def self.white_pawn_moves(co_ord)
    # co_ord == a2
    # possible moves from here:
    # - a3
    # - a4 - if first move
    # - b3 - if enemy piece on it
  end

  def self.white_rook_moves(_co_ord)
    'Rooked'
  end

  def self.white_bishop_moves(_co_ord)
    'Bishoped'
  end

  def self.white_knight_moves(_co_ord)
    'Knighted'
  end

  def self.white_queen_moves(_co_ord)
    'Queened'
  end

  def self.white_king_moves(_co_ord)
    'Kinged'
  end
end
