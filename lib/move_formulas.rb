module MoveFormulas
  def white_pawn(co_ord)
    x = co_ord[0]
    y = co_ord[1]
    [[x - 1, y], [x - 2, y], [x - 1, y - 1], [x - 1, y + 1]]
  end

  def black_pawn(co_ord)
    x = co_ord[0]
    y = co_ord[1]
    [[x + 1, y], [x + 2, y], [x + 1, y - 1], [x + 1, y + 1]]
  end

  def rook_vertical_up(co_ord)
    return_array = []
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x - 1, y]
      x -= 1
    end
    return_array
  end

  def rook_horizontal_right(co_ord, return_array)
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x, y + 1]
      y += 1
    end
    return_array
  end

  def rook_vertical_down(co_ord, return_array)
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x + 1, y]
      x += 1
    end
    return_array
  end

  def rook_horizontal_left(co_ord, return_array)
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x, y - 1]
      y -= 1
    end
    return_array
  end

  def bishop_up_right(co_ord)
    return_array = []
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x - 1, y + 1]
      x -= 1
      y += 1
    end
    return_array
  end

  def bishop_down_right(co_ord, return_array)
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x + 1, y + 1]
      x += 1
      y += 1
    end
    return_array
  end

  def bishop_down_left(co_ord, return_array)
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x + 1, y - 1]
      x += 1
      y -= 1
    end
    return_array
  end

  def bishop_up_left(co_ord, return_array)
    x = co_ord[0]
    y = co_ord[1]
    7.times do
      return_array << [x - 1, y - 1]
      x -= 1
      y -= 1
    end
    return_array
  end

  def king_all_directions(co_ord)
    x = co_ord[0]
    y = co_ord[1]
    [[x - 1, y], [x - 1, y - 1], [x - 1, y + 1], [x, y + 1], [x + 1, y + 1], [x + 1, y], [x + 1, y - 1], [x, y - 1]]
  end
end
