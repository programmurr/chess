module MoveFormulas
  def rook_vertical_up(co_ord)
    return_array = []
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x - 1, y]
      x -= 1
    end
    return_array.flatten
  end
end
