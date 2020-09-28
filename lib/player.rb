# frozen_string_literal: false

require 'pry'
require 'colorize'
require_relative 'piece'

class Player
  attr_accessor :name, :piece, :move, :color, :captured_pieces, :temp_cell
  def initialize(num)
    @name = "Player#{num}"
    @piece = nil
    @color = nil
    @move = nil
    @captured_pieces = []
    @temp_cell = nil
  end

  def move_piece(board)
    start_cell = board.get_cell(move[0])
    end_cell = board.get_cell(move[1])
    self.temp_cell = end_cell.value
    end_cell.value = start_cell.value
    start_cell.value = nil
  end

  def take_enemy_piece
    unless temp_cell.nil?
      captured_pieces << temp_cell
      self.temp_cell = nil
    end
  end

  def display_captured_pieces
    puts "#{name} captured pieces:"
    captured_pieces.each do |piece|
      if piece.color == 'Black'
        print piece.display_on_board.colorize(background: :white)
      elsif piece.color == 'White'
        print piece.display_for_capture.colorize(background: :black)
      end
    end
    puts
  end

  def enter_move
    enter_move_message
    move = $stdin.gets.chomp.to_s.downcase.split('')
    move.each.with_index do |char, index|
      if move.length > 4 || validation_checks?(char, index) == false
        raise 'That is not a valid coordinate, please re-enter'.colorize(:red)
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
  end

  def character_is_not_a_valid_number?(char, index)
    return true if index == 1 && !('1'..'8').include?(char)
    return true if index == 3 && !('1'..'8').include?(char)
  end

  def character_is_not_a_valid_letter?(char, index)
    return true if index.zero? && !('a'..'h').include?(char)
    return true if index == 2 && !('a'..'h').include?(char)
  end

  def convert_to_move(move)
    [move[0] + move[1], move[2] + move[3]]
  end

  def enter_move_message
    puts "#{name}, enter the 'from' and 'to' coordinates for the piece you want to move e.g. 'a2a4'"
  end
end
