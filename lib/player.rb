# frozen_string_literal: true

class Player
  attr_accessor :name
  def initialize(num)
    @name = "Player#{num}"
  end
end
