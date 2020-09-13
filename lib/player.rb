# frozen_string_literal: false

require_relative 'pieces/black_pieces'
require_relative 'pieces/white_pieces'

class Player
  attr_accessor :name, :piece
  def initialize(num)
    @name = "Player#{num}"
    @piece = nil
  end

  def enter_move
    enter_move_message
    move = $stdin.gets.chomp.to_s.split
    p move
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

new_player = Player.new(1)
new_player.enter_move
