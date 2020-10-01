# frozen_string_literal: true

# Changed to a Struct currently being used in Board, so this code is no longer in use
#   Remove if no issues
class Cell
  attr_accessor :co_ord, :value
  def initialize
    @co_ord = nil
    @value = nil
  end
end
