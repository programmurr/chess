# frozen_string_literal: true

require 'yaml'

module Serializable
  def serialize(file_name)
    File.open("save_files/#{file_name}.yaml", 'w') { |file| file.write(YAML.dump(self)) }
  end

  def load_game(choice)
    file_to_load = Dir.chdir('save_files') { Dir.glob('*.yaml').sort[choice] }
    YAML.load(File.read("save_files/#{file_to_load}"))
  rescue Errno::EISDIR
    puts "That file doesn't exist, please choose again"
    sleep 5
  end

  def unique_file_name
    Dir.mkdir('save_files')
    count = Dir.glob('save_files/*.yaml').length
    date_and_time = Time.new
    "#{count} - #{active_player.name} and #{next_player.name}: #{date_and_time.strftime('%d-%m-%Y %I:%M %p')}"
  rescue Errno::EEXIST
    count = Dir.glob('save_files/*.yaml').length
    date_and_time = Time.new
    "#{count} - #{active_player.name} and #{next_player.name}: #{date_and_time.strftime('%d-%m-%Y %I:%M %p')}"
  end
end
