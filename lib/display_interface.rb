# frozen_string_literal: true
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
    puts "Player 1 will be the white color and will go first."
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
end
