# frozen_string_literal: true

require 'yaml'

# Triggered from the GamePlay and Load classes. Creates a unique file name
#   and saves to a YAML. YAML chosen due to simplicity to implement over JSON
module Serializable
  def serialize(file_name)
    File.open("save_files/#{file_name}.yaml", 'w') { |file| file.write(YAML.dump(self)) }
  end

  def load_game(choice)
    file_to_load = Dir.chdir('save_files') { Dir.glob('*.yaml').sort[choice] }
    game = YAML.load(File.read("save_files/#{file_to_load}"))
    loop do
      game.game_loop
    end
  rescue Errno::EISDIR
    puts "That file doesn't exist, please choose again"
    sleep 5
  end

  def unique_file_name
    Dir.mkdir('save_files')
    count = Dir.glob('save_files/*.yaml').length
    "#{count} - #{active_player.name} and #{next_player.name}: #{Time.new.strftime('%d-%m-%Y %I:%M %p')}"
  rescue Errno::EEXIST
    count = Dir.glob('save_files/*.yaml').length
    "#{count} - #{active_player.name} and #{next_player.name}: #{Time.new.strftime('%d-%m-%Y %I:%M %p')}"
  end
end
