# frozen_string_literal: true

require_relative 'pieces/black_pieces'
require_relative 'pieces/white_pieces'

class Player
  attr_accessor :name, :piece
  def initialize(num)
    @name = "Player#{num}"
    @piece = nil
  end

  def assign_black_piece
    self.piece = BlackPiece.new
  end

  def assign_white_piece
    self.piece = WhitePiece.new
  end
end
