# frozen_string_literal: true

require_relative 'display_interface'
require_relative 'serializable'
require_relative 'gameplay'

class Menu
  include DisplayInterface
  include Serializable

  def initialize
    system 'clear'
    title
  end
end

class Welcome < Menu
  def initialize
    super
    welcome_options
  end
end

class Load < Menu
  def load_screen_check
    if Dir.glob('save_files/*.yaml').empty?
      puts "\nThere are no saved games. Returning to main menu."
      sleep 5
    elsif !Dir.glob('save_files/*.yaml').empty?
      load_options
      load_selection
    end
  end

  def load_selection
    user_input = gets.chomp.to_s
    load_game(user_input.to_i) if user_input != 'exit'
  end
end

class Rules < Menu
  RULES = File.read 'lib/files/rules.txt'

  def initialize
    super
    puts RULES
  end
end

class Instructions < Menu
  INSTRUCTIONS = File.read 'lib/files/instructions.txt'

  def initialize
    super
    puts INSTRUCTIONS
  end
end

class Names < Menu
  def set_player1_name
    player1_enter_name
    gets.chomp.to_s
  end

  def set_player2_name
    player2_enter_name
    gets.chomp.to_s
  end
end
