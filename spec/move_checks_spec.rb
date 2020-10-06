# frozen_string_literal: true

require_relative '../lib/move_checks'

describe MoveChecks do
  before do
    @board = Board.new
    @board.set_cell_coordinates
    @board.place_pawns
    @board.place_royalty
  end

  context '#castle_check?' do
    it 'returns false if the spaces between the a1 rook and the king are occupied' do
      @board.grid[7][2].value = nil
      @board.grid[7][3].value = nil
      player = double('Player', move: 'castlea1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns true if the spaces between the a1 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @board.grid[7][1].value = nil
      @board.grid[7][2].value = nil
      @board.grid[7][3].value = nil
      player = double('Player', move: 'castlea1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq true
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the rook' do
      @board.grid[7][0].value.number_of_moves = 2
      @board.grid[7][1].value = nil
      @board.grid[7][2].value = nil
      @board.grid[7][3].value = nil
      player = double('Player', move: 'castlea1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king' do
      @board.grid[7][4].value.number_of_moves = 2
      @board.grid[7][1].value = nil
      @board.grid[7][2].value = nil
      @board.grid[7][3].value = nil
      player = double('Player', move: 'castlea1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @board.grid[7][4].value.number_of_moves = 1
      @board.grid[7][0].value.number_of_moves = 1
      @board.grid[7][1].value = nil
      @board.grid[7][2].value = nil
      @board.grid[7][3].value = nil
      player = double('Player', move: 'castlea1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are occupied' do
      player = double('Player', move: 'castlea1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns true if the spaces between the h1 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @board.grid[7][5].value = nil
      @board.grid[7][6].value = nil
      player = double('Player', move: 'castleh1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq true
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the rook' do
      @board.grid[7][7].value.number_of_moves = 2
      @board.grid[7][5].value = nil
      @board.grid[7][6].value = nil
      player = double('Player', move: 'castleh1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king' do
      @board.grid[7][4].value.number_of_moves = 2
      @board.grid[7][5].value = nil
      @board.grid[7][6].value = nil
      player = double('Player', move: 'castleh1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @board.grid[7][4].value.number_of_moves = 2
      @board.grid[7][7].value.number_of_moves = 2
      @board.grid[7][5].value = nil
      @board.grid[7][6].value = nil
      player = double('Player', move: 'castleh1', color: 'White')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are occupied' do
      player = double('Player', move: 'castleh8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns true if the spaces between the h8 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @board.grid[0][5].value = nil
      @board.grid[0][6].value = nil
      player = double('Player', move: 'castleh8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq true
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the rook' do
      @board.grid[0][7].value.number_of_moves = 2
      @board.grid[0][5].value = nil
      @board.grid[0][6].value = nil
      player = double('Player', move: 'castleh8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king' do
      @board.grid[0][4].value.number_of_moves = 1
      @board.grid[0][5].value = nil
      @board.grid[0][6].value = nil
      player = double('Player', move: 'castleh8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @board.grid[0][4].value.number_of_moves = 3
      @board.grid[0][7].value.number_of_moves = 1
      @board.grid[0][5].value = nil
      @board.grid[0][6].value = nil
      player = double('Player', move: 'castleh8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are occupied' do
      @board.grid[0][2].value = nil
      @board.grid[0][3].value = nil
      player = double('Player', move: 'castlea8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns true if the spaces between the a8 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @board.grid[0][1].value = nil
      @board.grid[0][2].value = nil
      @board.grid[0][3].value = nil
      player = double('Player', move: 'castlea8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq true
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the rook' do
      @board.grid[0][0].value.number_of_moves = 2
      @board.grid[0][1].value = nil
      @board.grid[0][2].value = nil
      @board.grid[0][3].value = nil
      player = double('Player', move: 'castlea8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king' do
      @board.grid[0][4].value.number_of_moves = 21
      @board.grid[0][1].value = nil
      @board.grid[0][2].value = nil
      @board.grid[0][3].value = nil
      player = double('Player', move: 'castlea8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @board.grid[0][4].value.number_of_moves = 2
      @board.grid[0][0].value.number_of_moves = 21
      @board.grid[0][1].value = nil
      @board.grid[0][2].value = nil
      @board.grid[0][3].value = nil
      player = double('Player', move: 'castlea8', color: 'Black')
      expect(MoveChecks.new(player, @board).castle_check?).to eq false
    end
  end

  context '#cell_contains_piece?' do
    it 'returns true if the cell contains a piece to be moved' do
      player = double('Player', move: %w[h2 h3])
      expect(MoveChecks.new(player, @board).start_cell_contains_piece?).to eq true
    end

    it 'returns false if the cell does not contain a piece to be moved' do
      player = double('Player', move: %w[h3 h5])
      expect(MoveChecks.new(player, @board).start_cell_contains_piece?).to eq false
    end
  end

  context '#matching_piece_class?' do
    it "returns 'true' if the player piece class matches the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'White')
      expect(MoveChecks.new(player, @board).matching_piece_class?).to eq true
    end

    it "returns 'false' if the player piece class does not match the superclass of the piece to be moved" do
      player = double('Player', move: %w[a2 a4], color: 'Black')
      expect(MoveChecks.new(player, @board).matching_piece_class?).to eq false
    end
  end
end
