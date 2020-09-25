# frozen_string_literal: true

class Moves
  def self.remove_moves_beyond_the_board(all_moves)
    possible_array = []
    all_moves.each do |co_ord|
      next unless co_ord[0] < 8 && co_ord[1] < 8

      possible_array << co_ord if !co_ord[0].negative? && !co_ord[1].negative?
    end
    possible_array
  end

  attr_reader :co_ord
  attr_accessor :x, :y

  def initialize(co_ord)
    @co_ord = co_ord
    @x = co_ord[0]
    @y = co_ord[1]
  end
end

class BlackPawnMoves < Moves
  def first_moves
    all_moves = [[x + 1, y], [x + 2, y], [x + 1, y - 1], [x + 1, y + 1]]
    Moves.remove_moves_beyond_the_board(all_moves)
  end

  def moves
    all_moves = [[x + 1, y], [x + 1, y - 1], [x + 1, y + 1]]
    Moves.remove_moves_beyond_the_board(all_moves)
  end
end

class WhitePawnMoves < Moves
  def first_moves
    all_moves = [[x - 1, y], [x - 2, y], [x - 1, y - 1], [x - 1, y + 1]]
    Moves.remove_moves_beyond_the_board(all_moves)
  end

  def moves
    all_moves = [[x - 1, y], [x - 1, y - 1], [x - 1, y + 1]]
    Moves.remove_moves_beyond_the_board(all_moves)
  end
end

class KingMoves < Moves
  def moves
    all_moves = [[x - 1, y], [x - 1, y - 1], [x - 1, y + 1], [x, y + 1], [x + 1, y + 1], [x + 1, y], [x + 1, y - 1], [x, y - 1]]
    Moves.remove_moves_beyond_the_board(all_moves)
  end
end

class KnightMoves < Moves
  KNIGHT_MOVES_LIST = [2, 2, -2, -2, 1, 1, -1, -1].zip([1, -1, 1, -1, 2, -2, 2, -2])

  def moves
    all_moves = KNIGHT_MOVES_LIST.map { |a, b| [x + a, y + b] }
    Moves.remove_moves_beyond_the_board(all_moves)
  end
end

class BishopMoves < Moves
  def moves
    all_moves = bishop_up_right
    bishop_down_right(all_moves)
    bishop_down_left(all_moves)
    bishop_up_left(all_moves)
    Moves.remove_moves_beyond_the_board(all_moves)
  end

  private

  def reset_x_and_y
    self.x = co_ord[0]
    self.y = co_ord[1]
  end

  def bishop_up_right
    reset_x_and_y
    return_array = []
    7.times do
      return_array << [x - 1, y + 1]
      self.x -= 1
      self.y += 1
    end
    return_array
  end

  def bishop_down_right(return_array)
    reset_x_and_y
    7.times do
      return_array << [x + 1, y + 1]
      self.x += 1
      self.y += 1
    end
    return_array
  end

  def bishop_down_left(return_array)
    reset_x_and_y
    7.times do
      return_array << [x + 1, y - 1]
      self.x += 1
      self.y -= 1
    end
    return_array
  end

  def bishop_up_left(return_array)
    reset_x_and_y
    7.times do
      return_array << [x - 1, y - 1]
      self.x -= 1
      self.y -= 1
    end
    return_array
  end
end

class RookMoves < Moves
  def moves
    all_moves = rook_vertical_up
    rook_horizontal_right(all_moves)
    rook_vertical_down(all_moves)
    rook_horizontal_left(all_moves)
    Moves.remove_moves_beyond_the_board(all_moves)
  end

  private

  def reset_x_and_y
    self.x = co_ord[0]
    self.y = co_ord[1]
  end

  def rook_vertical_up
    reset_x_and_y
    return_array = []
    7.times do
      return_array << [x - 1, y]
      self.x -= 1
    end
    return_array
  end

  def rook_horizontal_right(return_array)
    reset_x_and_y
    7.times do
      return_array << [x, y + 1]
      self.y += 1
    end
    return_array
  end

  def rook_vertical_down(return_array)
    reset_x_and_y
    7.times do
      return_array << [x + 1, y]
      self.x += 1
    end
    return_array
  end

  def rook_horizontal_left(return_array)
    reset_x_and_y
    7.times do
      return_array << [x, y - 1]
      self.y -= 1
    end
    return_array
  end
end
