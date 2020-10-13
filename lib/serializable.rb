# frozen_string_literal: true

# At the moment, this is copied from the Hangman project
# This will be used as reference for the Chess serializable module
# Lines marked with '#' need to be adapted
module Serializable

  # Is there a way to iterate through instance variables and serialize/unserialize them?
  def save_game
    save_object = {
      board: game.board,
      player1: game.player1,
      player2: game.player2,
      active_player: game.active_player,
      next_player: game.next_player,
      en_passant_cache: game.en_passant_cache,
      white_check_cells: game.white_check_cells,
      black_check_cells: game.black_check_cells,
      check_scenario: game.check_scenario,
      do_not_switch_player: game.do_not_switch_player
    }
    File.open("save_files/#{file_name}.yaml", 'w') { |file| file.write(YAML.dump(save_object)) } #
  end

  def load_game(choice)
    file_to_load = Dir.chdir('save_files') { Dir.glob('*.yaml').sort[choice] } #
    loaded_game = YAML.safe_load(File.read("save_files/#{file_to_load}"), [Symbol]) #
    game.board = loaded_game[:board]
    game.player1 = loaded_game[:player1]
    game.player2 = loaded_game[:player2]
    game.active_player = loaded_game[:active_player]
    game.next_player = loaded_game[:next_player]
    game.en_passant_cache = loaded_game[:en_passant_cache]
    game.white_check_cells = loaded_game[:white_check_cells]
    game.black_check_cells = loaded_game[:black_check_cells]
    game.check_scenario = loaded_game[:check_scenario]
    game.do_not_switch_player = loaded_game[:do_not_switch_player]
  rescue Errno::EISDIR
    puts "That file doesn't exist, please choose again"
    sleep 3
    user_interface.load_screen #
    load_screen_choice #
  end
end

def create_unique_file_name
  Dir.mkdir('save_files')
  count = Dir.glob('save_files/*.yaml').length
  date_and_time = Time.new
  "#{count} - #{active_player.name} and #{next_player.name}: #{date_and_time.strftime('%d-%m-%Y %I:%M %p')}"
rescue Errno::EEXIST
  count = Dir.glob('save_files/*.yaml').length
  date_and_time = Time.new
  "#{count} - #{active_player.name} and #{next_player.name}: #{date_and_time.strftime('%d-%m-%Y %I:%M %p')}"
end

def load_screen
  system 'clear'
  puts 'Press the number of the file you want to load'
  Dir.chdir('save_files') { puts Dir.glob('*.yaml').sort }
end

def load_screen_check
  if Dir.glob('save_files/*.yaml').empty?
    puts 'There are no saved games. Launching new game!'
    sleep 3
    gameplay # 
  elsif !Dir.glob('save_files/*.yaml').empty?
    user_interface.load_screen # 
    load_screen_choice # 
  end
end
