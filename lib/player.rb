# frozen_string_literal: false

require 'colorize'
require_relative 'piece'

# Represent the users playing the game. 2 will be generated and allow the players to interact with the game
class Player
  attr_accessor :name, :piece, :move, :color, :captured_pieces, :temp_cell, :move_counter
  def initialize(num)
    @name = "Player#{num}"
    @piece = nil
    @color = nil
    @move = nil
    @captured_pieces = []
    @temp_cell = nil
    @move_counter = 0
  end

  def move_piece(start_cell, end_cell)
    self.temp_cell = end_cell.value
    end_cell.value = start_cell.value
    end_cell.value.number_of_moves += 1
    start_cell.value = nil
    false_en_passant_guard(end_cell)
  end

  def take_enemy_piece(board)
    if !temp_cell.nil? && temp_cell.class == InvisiblePawn
      captured_pieces << temp_cell.enemy_cell.value
      board.get_cell(temp_cell.enemy_cell.co_ord).value = nil
    elsif !temp_cell.nil?
      captured_pieces << temp_cell
    end
    self.temp_cell = nil
  end

  def display_captured_pieces
    puts "#{name}'s captured pieces:"
    captured_pieces.each do |piece|
      if piece.color == 'Black'
        print piece.display_on_board.colorize(background: :light_white)
      elsif piece.color == 'White'
        print piece.display_for_capture.colorize(background: :black)
      end
    end
    puts
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

  def false_en_passant_guard(end_cell)
    unless temp_cell.nil?
      self.temp_cell = nil if temp_cell.class == InvisiblePawn && end_cell.value.class != Pawn
    end
  end
end
