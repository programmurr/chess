# frozen_string_literal: true

require 'colorize'
require_relative '../../lib/pieces/black_pieces'

describe BlackPiece do
  context '#initialize' do
    let(:piece) { BlackPiece.new }
    it 'can have a color attribute with default set to Black' do
      expect(piece.color).to eq 'Black'
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

  context '#algebraic_name' do
    it 'has an algebraic name of P' do
      expect(pawn.algebraic_name).to eq 'P'
    end
  end
end

describe BlackRook do
  let(:rook) { BlackRook.new }
  context '#initialize' do
    it 'inherits the color attribute from the BlackPiece superclass' do
      expect(rook.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(rook.name).to eq 'BlackRook'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess rook' do
      expect(rook.display).to eq ' ♜ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of R' do
      expect(rook.algebraic_name).to eq 'R'
    end
  end
end

describe BlackBishop do
  let(:bishop) { BlackBishop.new }
  context '#initialize' do
    it 'inherits the color attribute from the BlackPiece superclass' do
      expect(bishop.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(bishop.name).to eq 'BlackBishop'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess bishop' do
      expect(bishop.display).to eq ' ♝ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of B' do
      expect(bishop.algebraic_name).to eq 'B'
    end
  end
end

describe BlackKnight do
  let(:knight) { BlackKnight.new }
  context '#initialize' do
    it 'inherits the color attribute from the BlackPiece superclass' do
      expect(knight.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(knight.name).to eq 'BlackKnight'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess knight' do
      expect(knight.display).to eq ' ♞ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of N' do
      expect(knight.algebraic_name).to eq 'N'
    end
  end
end

describe BlackQueen do
  let(:queen) { BlackQueen.new }
  context '#initialize' do
    it 'inherits the color attribute from the BlackPiece superclass' do
      expect(queen.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(queen.name).to eq 'BlackQueen'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess queen' do
      expect(queen.display).to eq ' ♛ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of Q' do
      expect(queen.algebraic_name).to eq 'Q'
    end
  end
end

describe BlackKing do
  let(:king) { BlackKing.new }
  context '#initialize' do
    it 'inherits the color attribute from the BlackPiece superclass' do
      expect(king.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(king.name).to eq 'BlackKing'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess king' do
      expect(king.display).to eq ' ♚ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of K' do
      expect(king.algebraic_name).to eq 'K'
    end
  end
end
