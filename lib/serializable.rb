# frozen_string_literal: true

# At the moment, this is copied from the Hangman project
# This will be used as reference for the Chess serializable module
module Serializable
  def save_game
    save_object = {
      guesses_remaining: player.guesses_remaining,
      blank_word: word_generator.blank_word,
      secret_word: word_generator.secret_word,
      incorrect_letters: player.incorrect_letters
    }
    File.open("save_files/#{file_name}.yaml", 'w') { |file| file.write(YAML.dump(save_object)) }
  end

  def load_game(choice)
    file_to_load = Dir.chdir('save_files') { Dir.glob('*.yaml').sort[choice] }
    loaded_game = YAML.safe_load(File.read("save_files/#{file_to_load}"), [Symbol])
    player.guesses_remaining = loaded_game[:guesses_remaining]
    word_generator.blank_word = loaded_game[:blank_word]
    player.incorrect_letters = loaded_game[:incorrect_letters]
    word_generator.secret_word = loaded_game[:secret_word]
  rescue Errno::EISDIR
    puts "That file doesn't exist, please choose again"
    sleep 3
    user_interface.load_screen
    load_screen_choice
  end
end

def create_unique_file_name
  Dir.mkdir('save_files')
  count = Dir.glob('save_files/*.yaml').length
  date_and_time = Time.new
  "#{count} - Hangman: #{date_and_time.strftime('%d-%m-%Y %I:%M %p')}"
rescue Errno::EEXIST
  count = Dir.glob('save_files/*.yaml').length
  date_and_time = Time.new
  "#{count} - Hangman: #{date_and_time.strftime('%d-%m-%Y %I:%M %p')}"
end
