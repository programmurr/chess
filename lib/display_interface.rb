# frozen_string_literal: true

require 'colorize'

# Contains all the text and error messages used by the game
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
    puts "\nPlayer 1 will be the white color and will go first."
    puts "\nPlayer 1, please type your name then press enter."
    puts
  end

  def player2_enter_name
    puts
    puts "\nPlayer 2 will be the black color and will go second."
    puts "\nPlayer 2, please type your name then press enter."
    puts
  end

  def castle_not_allowed
    puts "\nThat castling move is not allowed".colorize(color: :red)
    sleep 5
  end

  def select_piece(color)
    puts "\nSelect a #{color} piece!".colorize(color: :red)
    sleep 5
  end

  def cannot_attack_same_color
    puts "\nYou cannot land on pieces matching your color!".colorize(color: :red)
    sleep 5
  end

  def cannot_threaten_king
    puts "\nYou cannot put your King in a check situation!".colorize(color: :red)
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

  def invalid_move_message
    puts 'That is not valid, please re-enter your move'.colorize(:red)
    sleep 3
  end

  def promotion_message
    puts "\nYour pawn has landed on the last row of the board!".colorize(:green)
    puts 'According to the FIDE laws of chess, you must promote this piece!'.colorize(:green)
    puts "Enter 'queen', 'bishop', 'rook' or 'knight' to promote your pawn to that piece and finish the move".colorize(:green)
  end

  def remove_king_from_check
    puts 'You must make a move that removes your King from check!'.colorize(color: :red)
    sleep 3
  end

  def checkmate_message(name)
    puts 'Checkmate!'.colorize(color: :green)
    puts "Congratulations #{name}! You are the winner!"
    puts 'Thank you for playing!'
    sleep 3
  end

  def stalemate_message(name)
    puts 'Checkmate!'.colorize(color: :green)
    puts "Congratulations #{name}! You are the winner!"
    puts 'Thank you for playing!'
    sleep 3
  end

  def enter_move_message(name)
    puts "\n#{name}, enter the 'from' and 'to' coordinates for the piece you want to move e.g. 'a2a4'"
  end
end
