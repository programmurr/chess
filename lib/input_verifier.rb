# frozen_string_literal: true

require_relative 'display_interface'

class InputVerifier
  ACCEPTABLE_MOVES = %w[castlea1 castlea8 castleh1 castleh8 save myqueens].freeze

  include DisplayInterface

  attr_accessor :player
  attr_reader :move

  def initialize(player)
    @player = player
  end

  def verify
    loop do
      move = gets.chomp.to_s.downcase
      if ACCEPTABLE_MOVES.include?(move)
        player.move = move
        break
      elsif move.match?(/^[a-h][1-8][a-h][1-8]$/)
        player.move = move_formatter(move)
        break
      else
        invalid_move_message
        sleep 3
      end
    end
  end

  private

  def move_formatter(move)
    move.chars.each_slice(move.length / 2).map(&:join)
  end
end
