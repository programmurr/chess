# frozen_string_literal: true

require_relative 'gameplay'
require_relative 'display_interface'
include DisplayInterface

system 'clear'
title
welcome_options
instructions = File.read "lib/instructions.txt"

input = gets.chomp.to_s

if input == '3'
  system 'clear'
  title
  puts instructions
end
