# frozen_string_literal: true

require_relative 'moves'

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
                   'WhiteRook' => Moves.rook(co_ord),
                   'WhiteBishop' => Moves.bishop(co_ord),
                   'WhiteKnight' => Moves.knight(co_ord),
                   'WhiteQueen' => Moves.queen(co_ord),
                   'WhiteKing' => Moves.king(co_ord),
                   'BlackPawn' => Moves.black_pawn(co_ord),
                   'BlackRook' => Moves.rook(co_ord),
                   'BlackBishop' => Moves.bishop(co_ord),
                   'BlackKnight' => Moves.knight(co_ord),
                   'BlackQueen' => Moves.queen(co_ord),
                   'BlackKing' => Moves.king(co_ord) }
    moves_hash.fetch(class_name)
  end
end

class BlackPawn < Piece
  def initialize
    @color = 'Black'
  end

  def name
    self.class.to_s
  end

  def display
    " \u265F ".colorize(color: :black)
  end
end

class WhitePawn < Piece
  def initialize
    @color = 'White'
  end

  def name
    self.class.to_s
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    " \u2659 ".colorize(color: :black)
  end
end

class Rook < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def name
    self.class.to_s
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    if color == 'White'
      " \u2656 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265C ".colorize(color: :black)
    end
  end
end

class Bishop < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def name
    self.class.to_s
  end

  def display
    if color == 'White'
      " \u2657 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265D ".colorize(color: :black)
    end
  end
end

class Knight < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def name
    self.class.to_s
  end

  def display
    if color == 'White'
      " \u2658 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265E ".colorize(color: :black)
    end
  end
end

class Queen < Piece
  attr_reader :color
  def initialize(color)
    @color = color
  end

  def name
    self.class.to_s
  end

  def display
    if color == 'White'
      " \u2655 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265B ".colorize(color: :black)
    end
  end
end

class King < Piece
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def name
    self.class.to_s
  end

  def first_move?
    return true if first_move == true

    false
  end

  def display
    if color == 'White'
      " \u2654 ".colorize(color: :black)
    elsif color == 'Black'
      " \u265A ".colorize(color: :black)
    end
  end
end
