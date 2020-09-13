# frozen_string_literal: false

require_relative 'pieces/black_pieces'
require_relative 'pieces/white_pieces'

class Player
  attr_accessor :name, :piece, :move
  def initialize(num)
    @name = "Player#{num}"
    @piece = nil
    @move = nil
  end

  def enter_move
    enter_move_message
    move = $stdin.gets.chomp.to_s.downcase.split('')
    move.each.with_index do |char, index|
      if move.length > 5
        raise '1That is not a valid coordinate, please re-enter'
      elsif index.zero? && !('a'..'h').include?(char)
        raise '2That is not a valid coordinate, please re-enter'
      elsif index == 1 && !('1'..'8').include?(char)
        raise '3That is not a valid coordinate, please re-enter'
      elsif index == 2 && char != ' '
        raise '4That is not a valid coordinate, please re-enter'
      elsif index == 3 && !('a'..'h').include?(char)
        raise '5That is not a valid coordinate, please re-enter'
      elsif index == 4 && !('1'..'8').include?(char)
        raise '6That is not a valid coordinate, please re-enter'
      end
    end
    return_array = []
    return1 = move[0] + move[1]
    return2 = move[3] + move[4]
    return_array << return1
    return_array << return2
    @move = return_array
  end

  def assign_black_piece
    self.piece = BlackPiece.new
  end

  def assign_white_piece
    self.piece = WhitePiece.new
  end

  private

  def enter_move_message
    puts "#{name}, enter the 'from' and 'to' coordinates for the piece you want to move."
    puts "Enter the coordinates with a space in the middle e.g. 'a2 a4'"
  end
end

# new_player = Player.new(1)
# new_player.enter_move
