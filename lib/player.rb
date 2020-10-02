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
    end_cell.value.number_of_moves += 1
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
        print piece.display_on_board.colorize(background: :light_white)
      elsif piece.color == 'White'
        print piece.display_for_capture.colorize(background: :black)
      end
    end
    puts
  end

  def enter_move
    enter_move_message
    move = $stdin.gets.chomp.to_s.downcase
    return self.move = move if castle_check?(move)
    raise 'That is not a valid coordinate, please re-enter'.colorize(:red) unless move.match?(/^[a-h][1-8][a-h][1-8]$/)

    self.move = move.chars.each_slice(move.length / 2).map(&:join)
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

  def castle_check?(move)
    { 'castleh1' => true,
      'castleh8' => true,
      'castlea1' => true,
      'castlea8' => true }.fetch(move)
  rescue KeyError
    false
  end

  def enter_move_message
    puts "#{name}, enter the 'from' and 'to' coordinates for the piece you want to move e.g. 'a2a4'"
  end
end
