# frozen_string_literal: true

require_relative 'gameplay'
require_relative 'menus'
require_relative 'serializable'

include Serializable

# TODO:
# Prevent player putting their king into check
#   This already works for the king directly, but not if moving another pieces inadvertently causes it
# Serializable module
# Make tests

def selections
  Welcome.new

  while input = gets.chomp.to_s
    case input
    when '1'
      new_game
    when '2'
      load_menu
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
  game.assign_player_pieces
  loop do
    game.game_loop
  end
end

def load_menu
  Load.new.load_screen_check
  user_input = gets.chomp.to_i
  game = load_game(user_input)
  if game.class == GamePlay
    loop do
      game.game_loop
    end
  else
    selections
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
