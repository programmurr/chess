# frozen_string_literal: true

require_relative '../../lib/pieces/piece'

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
  let(:rook) { Rook.new('White') }
  context '#initialize' do
    it 'has a color attribute of White' do
      expect(rook.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(rook.name).to eq 'Rook'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess rook' do
      expect(rook.display).to eq ' ♖ '.colorize(color: :black)
    end
  end
end

describe Bishop do
  let(:bishop) { Bishop.new('White') }
  context '#initialize' do
    it 'has a color attribute of White' do
      expect(bishop.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(bishop.name).to eq 'Bishop'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess bishop' do
      expect(bishop.display).to eq ' ♗ '.colorize(color: :black)
    end
  end
end

describe Knight do
  let(:knight) { Knight.new('White') }
  context '#initialize' do
    it 'has a color attribute of White' do
      expect(knight.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(knight.name).to eq 'Knight'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess knight' do
      expect(knight.display).to eq ' ♘ '.colorize(color: :black)
    end
  end
end

describe Queen do
  let(:queen) { Queen.new('White') }
  context '#initialize' do
    it 'has a color attribute of White' do
      expect(queen.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(queen.name).to eq 'Queen'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess queen' do
      expect(queen.display).to eq ' ♕ '.colorize(color: :black)
    end
  end
end

describe King do
  let(:king) { King.new('White') }
  context '#initialize' do
    it 'has a color attribute of White' do
      expect(king.color).to eq 'White'
    end

    it 'generates its own name based on its sub-class name' do
      expect(king.name).to eq 'King'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a white chess king' do
      expect(king.display).to eq ' ♔ '.colorize(color: :black)
    end
  end
end
