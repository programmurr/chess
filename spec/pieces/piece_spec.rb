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
