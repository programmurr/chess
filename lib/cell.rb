# frozen_string_literal: true

# Change to a Struct to be used in the Board class?
class Cell
  attr_accessor :co_ord, :value, :counter, :remove
  def initialize
    @co_ord = nil
    @value = nil
    @counter = nil
    @remove = false
  end

  def adjascent_cells(pos_co_ord, queue)
    x = pos_co_ord[0]
    y = pos_co_ord[1]
    adjascent_positions = [[x - 1, y], [x - 1, y - 1], [x - 1, y + 1], [x, y + 1], [x + 1, y + 1], [x + 1, y], [x + 1, y - 1], [x, y - 1]]
    adjascent_positions.each { |position| queue << position }
    remove_moves_beyond_the_board(queue)
  end

  # Duplicated method. Necessary for now. Refactor
  def remove_moves_beyond_the_board(queue)
    possible_array = []
    queue.each do |co_ord|
      next unless co_ord[0] < 8 && co_ord[1] < 8

      possible_array << co_ord if !co_ord[0].negative? && !co_ord[1].negative?
    end
    possible_array
  end
end
