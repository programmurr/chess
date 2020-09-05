# frozen_string_literal: true

require_relative '../lib/cell'
describe Cell do
  context '#initialize' do
    let(:cell) { Cell.new }
    it 'creates a new instance of a cell object' do
      expect(cell).to be_instance_of(Cell)
    end

    it 'has a coordinate attribute which defaults to nil' do
      expect(cell.co_ord).to eq(nil)
    end

    it 'has a coordinate attribute that can be changed to a chess-board coordinate' do
      cell.co_ord = 'e4'
      expect(cell.co_ord).to eq 'e4'
    end

    it 'has a value attribute which defaults to nil' do
      expect(cell.value).to eq nil
    end

    it 'has a value attribute which can be set to a string piece name' do
      cell.value = 'WhiteKing'
      expect(cell.value).to eq 'WhiteKing'
    end
  end
end
