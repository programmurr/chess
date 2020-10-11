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
end
# Displays welcome screen
# Displays the captured pieces for both players
# Displays the board
# Asks player to input a valid move
# Can display instructions when triggered
# Can save game when triggered
