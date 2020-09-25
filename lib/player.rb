# frozen_string_literal: false

require 'pry'
require_relative 'piece'

class Player
  attr_accessor :name, :piece, :move, :color, :captured_pieces
  def initialize(num)
    @name = "Player#{num}"
    @piece = nil
    @color = nil
    @move = nil
    @captured_pieces = []
  end

  def display_captured_pieces
    captured_pieces.each do |piece|
      if piece.color == 'Black'
        puts piece.display_on_board
      elsif piece.color == 'White'
        piece.display_for_capture
      end
    end
  end

  def enter_move
    enter_move_message
    move = $stdin.gets.chomp.to_s.downcase.split('')
    move.each.with_index do |char, index|
      if move.length > 5 || validation_checks?(char, index) == false
        raise 'That is not a valid coordinate, please re-enter'
      end
    end
    self.move = convert_to_move(move)
  end

  def assign_black_piece
    self.piece = Piece.new('Black')
    self.color = 'Black'
  end

  def assign_white_piece
    self.piece = Piece.new('White')
    self.color = 'White'
  end

  private

  def validation_checks?(char, index)
    return false if character_is_not_a_valid_letter?(char, index)
    return false if character_is_not_a_valid_number?(char, index)
    return false if third_character_is_a_space?(char, index)
  end

  def character_is_not_a_valid_number?(char, index)
    return true if index == 1 && !('1'..'8').include?(char)
    return true if index == 4 && !('1'..'8').include?(char)
  end

  def character_is_not_a_valid_letter?(char, index)
    return true if index.zero? && !('a'..'h').include?(char)
    return true if index == 3 && !('a'..'h').include?(char)
  end

  def third_character_is_a_space?(char, index)
    return true if index == 2 && char != ' '
  end

  def convert_to_move(move)
    return1 = move[0] + move[1]
    return2 = move[3] + move[4]
    [return1, return2]
  end

  def enter_move_message
    puts "#{name}, enter the 'from' and 'to' coordinates for the piece you want to move."
    puts "Enter the coordinates with a space in the middle e.g. 'a2 a4'"
  end
end
