# frozen_string_literal: true

require 'colorize'
require_relative '../lib/piece'
require_relative '../lib/board'

describe Piece do
  context '#initialize' do
    it 'can have a color attribute with default set to White' do
      piece = Piece.new('White')
      expect(piece.color).to eq 'White'
    end

    it 'can have a color attribute with default set to Black' do
      piece = Piece.new('Black')
      expect(piece.color).to eq 'Black'
    end
  end

  context '#name' do
    it 'has a name matching its class' do
      piece = Piece.new('Black')
      expect(piece.name).to eq 'Piece'
    end
  end

  context '#all_moves_from_current_position' do
    before do
      @board = Board.new
      @board.set_cell_coordinates
      @board.place_pawns
      @board.place_royalty
    end

    it 'can list all co_ordinates in all directions a KNIGHT can move to, including cells with other pieces' do
      knight = Knight.new('White')
      co_ord = [3, 3]
      predicted_moves = [[2, 1], [4, 1], [1, 2], [1, 4], [2, 5], [4, 5], [5, 4], [5, 2]]
      actual_moves = knight.all_move_coordinates_from_current_position(co_ord, knight.color)
      expect(predicted_moves.difference(actual_moves)).to eq []
    end

    it 'can list all co_ordinates in all directions a BISHOP can move to, including cells with other pieces' do
      bishop = Bishop.new('Black')
      co_ord = [4, 4]
      predicted_moves = { 'up_right' => [[3, 5], [2, 6], [1, 7]],
                          'down_right' => [[5, 5], [6, 6], [7, 7]],
                          'down_left' => [[5, 3], [6, 2], [7, 1]],
                          'up_left' => [[3, 3], [2, 2], [1, 1], [0, 0]] }
      actual_moves = bishop.all_move_coordinates_from_current_position(co_ord, bishop.color)
      expect(predicted_moves).to eq actual_moves
    end

    it 'can list all co_ordinates in all directions a ROOK can move to, including cells with other pieces' do
      rook = Rook.new('White')
      co_ord = [3, 2]
      predicted_moves = { 'up' => [[2, 2], [1, 2], [0, 2]],
                          'right' => [[3, 3], [3, 4], [3, 5], [3, 6], [3, 7]],
                          'down' => [[4, 2], [5, 2], [6, 2], [7, 2]],
                          'left' => [[3, 1], [3, 0]] }
      actual_moves = rook.all_move_coordinates_from_current_position(co_ord, rook.color)
      expect(predicted_moves).to eq actual_moves
    end

    it 'can list all co_ordinates in all directions a QUEEN can move to, including cells with other pieces' do
      queen = Queen.new('Black')
      co_ord = [3, 2]
      predicted_moves = { 'up' => [[2, 2], [1, 2], [0, 2]],
                          'right' => [[3, 3], [3, 4], [3, 5], [3, 6], [3, 7]],
                          'down' => [[4, 2], [5, 2], [6, 2], [7, 2]],
                          'left' => [[3, 1], [3, 0]],
                          'up_right' => [[2, 3], [1, 4], [0, 5]],
                          'down_right' => [[4, 3], [5, 4], [6, 5], [7, 6]],
                          'down_left' => [[4, 1], [5, 0]],
                          'up_left' => [[2, 1], [1, 0]] }
      actual_moves = queen.all_move_coordinates_from_current_position(co_ord, queen.color)
      expect(predicted_moves).to eq actual_moves
    end

    it 'can list all co_ordinates in all directions a KING can move to, including cells with other pieces' do
      king = King.new('White')
      co_ord = [5, 6]
      predicted_moves = { 'up' => [[4, 6]], 'up_right' => [[4, 7]], 'right' => [[5, 7]], 'down_right' => [[6, 7]], 'down' => [[6, 6]], 'down_left' => [[6, 5]], 'left' => [[5, 5]], 'up_left' => [[4, 5]] }
      actual_moves = king.all_move_coordinates_from_current_position(co_ord, king.color)
      expect(predicted_moves).to eq actual_moves
    end

    it 'can list all co_ordinates, including attacks, a white pawn can move to on its first move' do
      pawn = Pawn.new('White')
      co_ord = [6, 1]
      predicted_moves = { 'up' => [[5, 1]], 'double_up' => [[4, 1]], 'up_left' => [[5, 0]], 'up_right' => [[5, 2]] }
      actual_moves = pawn.all_move_coordinates_from_current_position(co_ord, pawn.color)
      expect(predicted_moves).to eq actual_moves
    end

    it 'can list all co_ordinates, including attacks, a white pawn can move to on a move other than its first move' do
      pawn = Pawn.new('White')
      co_ord = [5, 6]
      predicted_moves = { 'up' => [[4, 6]], 'double_up' => [], 'up_left' => [[4, 5]], 'up_right' => [[4, 7]] }
      actual_moves = pawn.all_move_coordinates_from_current_position(co_ord, pawn.color)
      expect(predicted_moves).to eq actual_moves
    end

    it 'can list all co_ordinates, including attacks, a black pawn can move to on its first move' do
      pawn = Pawn.new('Black')
      co_ord = [1, 3]
      predicted_moves = { 'down' => [[2, 3]], 'double_down' => [[3, 3]], 'down_left' => [[2, 2]], 'down_right' => [[2, 4]] }
      actual_moves = pawn.all_move_coordinates_from_current_position(co_ord, pawn.color)
      expect(predicted_moves).to eq actual_moves
    end

    it 'can list all co_ordinates, including attacks, a black  can move to on a move other than its first move' do
      pawn = Pawn.new('Black')
      co_ord = [3, 2]
      predicted_moves = { 'down' => [[4, 2]], 'double_down' => [], 'down_left' => [[4, 1]], 'down_right' => [[4, 3]] }
      actual_moves = pawn.all_move_coordinates_from_current_position(co_ord, pawn.color)
      expect(predicted_moves).to eq actual_moves
    end
  end
end

describe Pawn do
  let(:white_pawn) { Pawn.new('White') }
  let(:black_pawn) { Pawn.new('Black') }

  context '#initialize' do
    it 'can have a color attribute of White' do
      expect(white_pawn.color).to eq 'White'
    end

    it 'can have a color attribute of Black' do
      expect(black_pawn.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(black_pawn.name).to eq 'Pawn'
    end

    it 'generates its own name based on its sub-class name' do
      expect(white_pawn.name).to eq 'Pawn'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a White chess pawn' do
      expect(white_pawn.display_on_board).to eq ' ♙ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a Black chess pawn' do
      expect(black_pawn.display_on_board).to eq " \u265F ".colorize(color: :black)
    end
  end
end

describe Rook do
  let(:black_rook) { Rook.new('Black') }
  let(:white_rook) { Rook.new('White') }
  context '#initialize' do
    it 'can have a color attribute of Black' do
      expect(black_rook.color).to eq 'Black'
    end

    it 'can have a color attribute of White' do
      expect(white_rook.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(black_rook.name).to eq 'Rook'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess rook' do
      expect(black_rook.display_on_board).to eq ' ♜ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess rook' do
      expect(white_rook.display_on_board).to eq ' ♖ '.colorize(color: :black)
    end
  end
end

describe Bishop do
  let(:black_bishop) { Bishop.new('Black') }
  let(:white_bishop) { Bishop.new('White') }
  context '#initialize' do
    it 'can have a color attribute set to Black' do
      expect(black_bishop.color).to eq 'Black'
    end

    it 'can have a color attribute set to White' do
      expect(white_bishop.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(white_bishop.name).to eq 'Bishop'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess bishop' do
      expect(black_bishop.display_on_board).to eq ' ♝ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess bishop' do
      expect(white_bishop.display_on_board).to eq ' ♗ '.colorize(color: :black)
    end
  end
end

describe Knight do
  let(:black_knight) { Knight.new('Black') }
  let(:white_knight) { Knight.new('White') }

  context '#initialize' do
    it 'can have a color attribute set to black' do
      expect(black_knight.color).to eq 'Black'
    end

    it 'can have a color attribute of White' do
      expect(white_knight.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(black_knight.name).to eq 'Knight'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess knight' do
      expect(black_knight.display_on_board).to eq ' ♞ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess knight' do
      expect(white_knight.display_on_board).to eq ' ♘ '.colorize(color: :black)
    end
  end
end

describe Queen do
  let(:black_queen) { Queen.new('Black') }
  let(:white_queen) { Queen.new('White') }

  context '#initialize' do
    it 'can have a color attribute set to Black' do
      expect(black_queen.color).to eq 'Black'
    end

    it 'can have a color attribute set to White' do
      expect(white_queen.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(black_queen.name).to eq 'Queen'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess queen' do
      expect(black_queen.display_on_board).to eq ' ♛ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess queen' do
      expect(white_queen.display_on_board).to eq ' ♕ '.colorize(color: :black)
    end
  end
end

describe King do
  let(:black_king) { King.new('Black') }
  let(:white_king) { King.new('White') }

  context '#initialize' do
    it 'can have a color attribute set to black' do
      expect(black_king.color).to eq 'Black'
    end

    it 'can have a color attribute set to White' do
      expect(white_king.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(black_king.name).to eq 'King'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess king' do
      expect(black_king.display_on_board).to eq ' ♚ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess king' do
      expect(white_king.display_on_board).to eq ' ♔ '.colorize(color: :black)
    end
  end

  context '#adjascent_cells' do
    before do 
      @board = Board.new
      @board.set_cell_coordinates
      @board.place_pawns
      @board.place_royalty  
    end

    it 'returns all adjascent cell co ords around the white king, regardless of what is on them, from the start position' do
      expected_cells = %w[d1 d2 e2 f1 f2]
      expect(@board.grid[7][4].value.adjascent_cells([7, 4], @board)).to eq expected_cells
    end

    it 'returns all adjascent cell co ords around the black king, regardless of what is on them, from the start position' do
      expected_cells = %w[d7 d8 e7 f7 f8]
      expect(@board.grid[0][4].value.adjascent_cells([0, 4], @board)).to eq expected_cells
    end

    it 'returns all adjascent cell co ords around the white king, regardless of what is on them, from a random board position' do
      @board.grid[3][1].value = King.new('White')
      expected_cells = %w[a4 a5 a6 b4 b6 c4 c5 c6]
      expect(@board.grid[3][1].value.adjascent_cells([3, 1], @board)).to eq expected_cells
    end

    it 'returns all adjascent cell co ords around the black king, regardless of what is on them, from a random board position' do
      @board.grid[4][6].value = King.new('Black')
      expected_cells = %w[f3 f4 f5 g3 g5 h3 h4 h5]
      expect(@board.grid[4][6].value.adjascent_cells([4, 6], @board)).to eq expected_cells
    end
  end
end
