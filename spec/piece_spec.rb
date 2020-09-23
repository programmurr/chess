# frozen_string_literal: true

require 'colorize'
require_relative '../lib/piece'

describe Piece do
  context '#initialize' do
    it 'can have a color attribute with default set to White' do
      piece = Piece.new('White')
      expect(piece.color).to eq 'White'
    end

    it 'can have a color attribute with default set to White' do
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
    it 'can list all co_ordinates in all directions a KNIGHT can move to, including cells with other pieces' do
      knight = Knight.new('White')
      co_ord = [3, 3]
      predicted_moves = [[2, 1], [4, 1], [1, 2], [1, 4], [2, 5], [4, 5], [5, 4], [5, 2]]
      actual_moves = knight.all_move_coordinates_from_current_position(co_ord)
      expect(predicted_moves.difference(actual_moves)).to eq []
    end

    it 'can list all co_ordinates in all directions a BISHOP can move to, including cells with other pieces' do
      bishop = Bishop.new('Black')
      co_ord = [4, 4]
      predicted_moves = [[3, 3], [2, 2], [1, 1], [0, 0],
                         [3, 5], [2, 6], [1, 7],
                         [5, 5], [6, 6], [7, 7],
                         [5, 3], [6, 2], [7, 1]]
      actual_moves = bishop.all_move_coordinates_from_current_position(co_ord)
      expect(predicted_moves.difference(actual_moves)).to eq []
    end

    it 'can list all co_ordinates in all directions a ROOK can move to, including cells with other pieces' do
      rook = Rook.new('White')
      co_ord = [3, 2]
      predicted_moves = [[2, 2], [1, 2], [0, 2],
                         [3, 3], [3, 4], [3, 5], [3, 6], [3, 7],
                         [4, 2], [5, 2], [6, 2], [7, 2],
                         [3, 1], [3, 0]]
      actual_moves = rook.all_move_coordinates_from_current_position(co_ord)
      expect(predicted_moves.difference(actual_moves)).to eq []
    end

    it 'can list all co_ordinates in all directions a QUEEN can move to, including cells with other pieces' do
      queen = Queen.new('Black')
      co_ord = [2, 3]
      predicted_moves = [[1, 3], [0, 3],
                         [1, 4], [0, 5],
                         [2, 4], [2, 5], [2, 6], [2, 7],
                         [3, 3], [4, 3], [5, 3], [6, 3], [7, 3],
                         [2, 2], [2, 1], [2, 0],
                         [1, 2], [0, 1]]
      actual_moves = queen.all_move_coordinates_from_current_position(co_ord)
      expect(predicted_moves.difference(actual_moves)).to eq []
    end

    it 'can list all co_ordinates in all directions a KING can move to, including cells with other pieces' do
      king = King.new('White')
      co_ord = [5, 6]
      predicted_moves = [[4, 6], [4, 7], [5, 7], [6, 7], [6, 6], [6, 5], [5, 5], [4, 5]]
      actual_moves = king.all_move_coordinates_from_current_position(co_ord)
      expect(predicted_moves.difference(actual_moves)).to eq []
    end
  end
end

describe WhitePawn do
  let(:white_pawn) { WhitePawn.new('White') }

  context '#initialize' do
    it 'can have a color attribute of White' do
      expect(white_pawn.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(white_pawn.name).to eq 'WhitePawn'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a White chess pawn' do
      expect(white_pawn.display).to eq ' ♙ '.colorize(color: :black)
    end
  end
end

describe BlackPawn do
  let(:black_pawn) { BlackPawn.new('Black') }

  context '#initialize' do
    it 'can have a color attribute of Black' do
      expect(black_pawn.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(black_pawn.name).to eq 'BlackPawn'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess pawn' do
      expect(black_pawn.display).to eq " \u265F ".colorize(color: :black)
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
      expect(black_rook.display).to eq ' ♜ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess rook' do
      expect(white_rook.display).to eq ' ♖ '.colorize(color: :black)
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
      expect(black_bishop.display).to eq ' ♝ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess bishop' do
      expect(white_bishop.display).to eq ' ♗ '.colorize(color: :black)
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
      expect(black_knight.display).to eq ' ♞ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess knight' do
      expect(white_knight.display).to eq ' ♘ '.colorize(color: :black)
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
      expect(black_queen.display).to eq ' ♛ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess queen' do
      expect(white_queen.display).to eq ' ♕ '.colorize(color: :black)
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
      expect(black_king.display).to eq ' ♚ '.colorize(color: :black)
    end

    it 'can display a unicode character representing a White chess king' do
      expect(white_king.display).to eq ' ♔ '.colorize(color: :black)
    end
  end
end
