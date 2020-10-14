# frozen_string_literal: true

require 'colorize'

module DisplayInterface
  def title
    puts '
      ___           ___           ___           ___           ___
     /\  \         /\__\         /\  \         /\  \         /\  \
    /::\  \       /:/  /        /::\  \       /::\  \       /::\  \
   /:/\:\  \     /:/__/        /:/\:\  \     /:/\ \  \     /:/\ \  \
  /:/  \:\  \   /::\  \ ___   /::\~\:\  \   _\:\~\ \  \   _\:\~\ \  \
 /:/__/ \:\__\ /:/\:\  /\__\ /:/\:\ \:\__\ /\ \:\ \ \__\ /\ \:\ \ \__\
 \:\  \  \/__/ \/__\:\/:/  / \:\~\:\ \/__/ \:\ \:\ \/__/ \:\ \:\ \/__/
  \:\  \            \::/  /   \:\ \:\__\    \:\ \:\__\    \:\ \:\__\
   \:\  \           /:/  /     \:\ \/__/     \:\/:/  /     \:\/:/  /
    \:\__\         /:/  /       \:\__\        \::/  /       \::/  /
     \/__/         \/__/         \/__/         \/__/         \/__/ '
  end

  def welcome_options
    puts
    puts
    puts 'Enter 1 to start a new game'.center(70)
    puts
    puts 'Enter 2 to load a saved game'.center(70)
    puts
    puts 'Enter 3 to read the rules of Chess'.center(70)
    puts
    puts 'Enter 4 for instructions on how to play'.center(70)
    puts
  end

  def player1_enter_name
    puts
    puts
    puts 'Player 1 will be the white color and will go first.'
    puts "\nPlayer 1, please type your name then press enter."
    puts
  end

  def player2_enter_name
    puts
    puts
    puts 'Player 2 will be the black color and will go second.'
    puts "\nPlayer 2, please type your name then press enter."
    puts
  end

  def castle_not_allowed
    puts
    puts 'That castling move is not allowed'.colorize(color: :red)
    sleep 5
  end

  def select_piece(color)
    puts
    puts "Select a #{color} piece!".colorize(color: :red)
    sleep 5
  end

  def cannot_attack_same_color
    puts
    puts 'You cannot land on pieces matching your color!'.colorize(color: :red)
    sleep 5
  end

  def cannot_threaten_king
    puts
    puts 'You cannot put your King in a check situation!'.colorize(color: :red)
    sleep 5
  end

  def saved_message(file_name)
    puts
    puts "\nYour game has been saved as #{file_name}".colorize(color: :green)
    puts "\nSelect it from the main menu when you play next".colorize(color: :green)
    sleep 8
  end

  def load_options
    puts "\nEnter the number of the file you want to load, or enter 'exit' to return to the main menu:"
    puts
    Dir.chdir('save_files') { puts Dir.glob('*.yaml').sort }
    puts
  end
end
