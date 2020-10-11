# frozen_string_literal: true

require_relative 'display_interface'

class Menu
  include DisplayInterface

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
  def initialize
    super
  end

  def set_player1_name
    player1_enter_name
    gets.chomp.to_s
  end

  def set_player2_name
    player2_enter_name
    gets.chomp.to_s
  end
end
