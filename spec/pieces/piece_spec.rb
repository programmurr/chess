# frozen_string_literal: true

require 'colorize'
require_relative '../../lib/pieces/piece'

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
    it 'has a name matching its color' do
      piece = Piece.new('Black')
      expect(piece.name).to eq 'BlackPiece'
    end

    it 'has a name matching its color' do
      piece = Piece.new('White')
      expect(piece.name).to eq 'WhitePiece'
    end
  end
end

describe BlackPawn do
  let(:pawn) { BlackPawn.new }
  context '#initialize' do
    it 'inherits the color attribute from the BlackPiece superclass' do
      expect(pawn.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(pawn.name).to eq 'BlackPawn'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess pawn' do
      expect(pawn.display).to eq " \u265F ".colorize(color: :black)
    end
  end
end

describe WhitePawn do
  let(:pawn) { WhitePawn.new }
  context '#initialize' do
    it 'has a color attribute of White' do
      expect(pawn.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(pawn.name).to eq 'WhitePawn'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess pawn' do
      expect(pawn.display).to eq ' ♙ '.colorize(color: :black)
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
