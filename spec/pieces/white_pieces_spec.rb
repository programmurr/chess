# frozen_string_literal: true

require_relative '../../lib/pieces/white_pieces'

describe WhitePiece do
  context '#initialize' do
    let(:piece) { WhitePiece.new }
    it 'can have a color attribute with default set to White' do
      expect(piece.color).to eq 'White'
    end
  end
end

describe WhitePawn do
  let(:pawn) { WhitePawn.new }
  context '#initialize' do
    it 'inherits the color attribute from the WhitePiece superclass' do
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

  context '#algebraic_name' do
    it 'has an algebraic name of P' do
      expect(pawn.algebraic_name).to eq 'P'
    end
  end
end

describe WhiteRook do
  let(:rook) { WhiteRook.new }
  context '#initialize' do
    it 'inherits the color attribute from the WhitePiece superclass' do
      expect(rook.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(rook.name).to eq 'WhiteRook'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess rook' do
      expect(rook.display).to eq ' ♖ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of R' do
      expect(rook.algebraic_name).to eq 'R'
    end
  end
end

describe WhiteBishop do
  let(:bishop) { WhiteBishop.new }
  context '#initialize' do
    it 'inherits the color attribute from the WhitePiece superclass' do
      expect(bishop.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(bishop.name).to eq 'WhiteBishop'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess bishop' do
      expect(bishop.display).to eq ' ♗ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of B' do
      expect(bishop.algebraic_name).to eq 'B'
    end
  end
end

describe WhiteKnight do
  let(:knight) { WhiteKnight.new }
  context '#initialize' do
    it 'inherits the color attribute from the WhitePiece superclass' do
      expect(knight.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(knight.name).to eq 'WhiteKnight'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess knight' do
      expect(knight.display).to eq ' ♘ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of N' do
      expect(knight.algebraic_name).to eq 'N'
    end
  end
end

describe WhiteQueen do
  let(:queen) { WhiteQueen.new }
  context '#initialize' do
    it 'inherits the color attribute from the WhitePiece superclass' do
      expect(queen.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(queen.name).to eq 'WhiteQueen'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess queen' do
      expect(queen.display).to eq ' ♕ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of Q' do
      expect(queen.algebraic_name).to eq 'Q'
    end
  end
end

describe WhiteKing do
  let(:king) { WhiteKing.new }
  context '#initialize' do
    it 'inherits the color attribute from the WhitePiece superclass' do
      expect(king.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(king.name).to eq 'WhiteKing'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess king' do
      expect(king.display).to eq ' ♔ '.colorize(color: :black)
    end
  end

  context '#algebraic_name' do
    it 'has an algebraic name of K' do
      expect(king.algebraic_name).to eq 'K'
    end
  end
end
