require 'pry'

class ValidMoves
  def self.moves(class_name)
    moves_hash = { 'WhitePawn' => white_pawn_moves,
                   'WhiteRook' => white_rook_moves,
                   'WhiteBishop' => white_bishop_moves,
                   'WhiteKnight' => white_knight_moves,
                   'WhiteQueen' => white_queen_moves,
                   'WhiteKing' => white_king_moves }
    moves_hash.fetch(class_name)
  end

  def self.white_pawn_moves
    'Pawned'
  end

  def self.white_rook_moves
    'Rooked'
  end

  def self.white_bishop_moves
    'Bishoped'
  end

  def self.white_knight_moves
    'Knighted'
  end

  def self.white_queen_moves
    'Queened'
  end

  def self.white_king_moves
    'Kinged'
  end
end
