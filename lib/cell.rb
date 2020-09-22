# frozen_string_literal: true

# Change to a Struct to be used in the Board class?
class Cell
  attr_accessor :co_ord, :value
  def initialize
    @co_ord = nil
    @value = nil
    @counter = nil
    @remove = false
  end
end
