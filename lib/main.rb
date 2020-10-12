# frozen_string_literal: true

require_relative 'gameplay'
require_relative 'menus'

# TODO:
#   If check is true, the king MUST be moved out of danger
#      The next move must remove it from the cells under attack list
#   Castling:
#      King must not pass over any cells under attack
#      King must not land in check
#   Serializable module

def selections
  Welcome.new

  while input = gets.chomp.to_s
    case input
    when '1'
      new_game
    when '2'
      # Load game
    when '3'
      rules
    when '4'
      instructions
    else
      puts 'Please try again'
      sleep 2
    end
  end
end

def new_game
  player1 = Player.new(1)
  player2 = Player.new(2)
  player1.name = Names.new.set_player1_name
  player2.name = Names.new.set_player2_name
  game = GamePlay.new(player1: player1, player2: player2)
  game.setup_board
  game.assign_player1_white_piece
  game.player1_as_active_player
  loop do
    game.game_loop
  end
end

def rules
  Rules.new
  while input = gets.chomp.to_s
    if input == '1'
      selections
    else 
      puts "Enter '1' to return to the title screen"
    end
  end
end

def instructions
  Instructions.new
  while input = gets.chomp.to_s
    if input == '1'
      selections
    else
      puts "Enter '1' to return to the title screen"
    end
  end
end

selections
