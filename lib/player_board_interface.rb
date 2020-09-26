# frozen_string_literal: true

require 'pry'
require_relative 'board'
require_relative 'player'

class PlayerBoardInterface
  attr_reader :player, :board
  attr_accessor :start_cell, :end_cell, :temp_cell

  def initialize(player, board)
    @player = player
    @board = board
    @start_cell = board.get_cell(player.move[0])
    @end_cell = board.get_cell(player.move[1])
    @temp_cell = nil
  end

  def move_piece
    self.temp_cell = end_cell.value
    end_cell.value = start_cell.value
    start_cell.value = nil
  end

  def take_enemy_piece
    unless temp_cell.nil?
      player.captured_pieces << temp_cell
      self.temp_cell = nil
    end
  end
end
