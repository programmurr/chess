# frozen_string_literal: true

require 'colorize'
require_relative '../../lib/pieces/piece'

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

describe Rook do
  let(:rook) { Rook.new('Black') }
  context '#initialize' do
    it 'has a color attribute of black' do
      expect(rook.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(rook.name).to eq 'Rook'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess rook' do
      expect(rook.display).to eq ' ♜ '.colorize(color: :black)
    end
  end
end

describe Bishop do
  let(:bishop) { Bishop.new('Black') }
  context '#initialize' do
    it 'has a color attribute set to Black' do
      expect(bishop.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(bishop.name).to eq 'Bishop'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess bishop' do
      expect(bishop.display).to eq ' ♝ '.colorize(color: :black)
    end
  end
end

describe Knight do
  let(:knight) { Knight.new('Black') }
  context '#initialize' do
    it 'has a color attribute set to black' do
      expect(knight.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(knight.name).to eq 'Knight'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess knight' do
      expect(knight.display).to eq ' ♞ '.colorize(color: :black)
    end
  end
end

describe Queen do
  let(:queen) { Queen.new('Black') }
  context '#initialize' do
    it 'has a color attribute set to black' do
      expect(queen.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(queen.name).to eq 'Queen'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess queen' do
      expect(queen.display).to eq ' ♛ '.colorize(color: :black)
    end
  end
end

describe King do
  let(:king) { King.new('Black') }
  context '#initialize' do
    it 'has a color attribute set to black' do
      expect(king.color).to eq 'Black'
    end

    it 'generates its own name based on its sub-class name' do
      expect(king.name).to eq 'King'
    end
  end

  context '#display' do
    it 'can display a unicode character representing a Black chess king' do
      expect(king.display).to eq ' ♚ '.colorize(color: :black)
    end
  end
end
