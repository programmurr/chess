# frozen_string_literal: true

require_relative '../lib/move_checks'

describe MoveChecks do
  before do
    @board = Board.new
    @board.set_cell_coordinates
    @board.place_pawns
    @board.place_royalty
  end

  # context '#castle_check?' do
  #   before do
  #     @game = GamePlay.new
  #     @game.setup_board
  #     @game.assign_player1_white_piece
  #     @game.player1_as_active_player
  #   end

  #   it 'returns false if the spaces between the a1 rook and the king are occupied' do
  #     @game.board.grid[7][2].value = nil
  #     @game.board.grid[7][3].value = nil
  #     @game.active_player.move = 'castlea1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns true if the spaces between the a1 rook and the king are unoccupied and it is the first move of the rook and the king' do
  #     @game.board.grid[7][1].value = nil
  #     @game.board.grid[7][2].value = nil
  #     @game.board.grid[7][3].value = nil
  #     @game.active_player.move = 'castlea1'
  #     expect(@game.castle_check?).to eq true
  #   end

  #   it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the rook' do
  #     @game.board.grid[7][0].value.number_of_moves = 2
  #     @game.board.grid[7][1].value = nil
  #     @game.board.grid[7][2].value = nil
  #     @game.board.grid[7][3].value = nil
  #     @game.active_player.move = 'castlea1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king' do
  #     @game.board.grid[7][4].value.number_of_moves = 2
  #     @game.board.grid[7][1].value = nil
  #     @game.board.grid[7][2].value = nil
  #     @game.board.grid[7][3].value = nil
  #     @game.active_player.move = 'castlea1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
  #     @game.board.grid[7][4].value.number_of_moves = 1
  #     @game.board.grid[7][0].value.number_of_moves = 1
  #     @game.board.grid[7][1].value = nil
  #     @game.board.grid[7][2].value = nil
  #     @game.board.grid[7][3].value = nil
  #     @game.active_player.move = 'castlea1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the h1 rook and the king are occupied' do
  #     @game.active_player.move = 'castleh1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns true if the spaces between the h1 rook and the king are unoccupied and it is the first move of the rook and the king' do
  #     @game.board.grid[7][5].value = nil
  #     @game.board.grid[7][6].value = nil
  #     @game.active_player.move = 'castleh1'
  #     expect(@game.castle_check?).to eq true
  #   end

  #   it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the rook' do
  #     @game.board.grid[7][7].value.number_of_moves = 2
  #     @game.board.grid[7][5].value = nil
  #     @game.board.grid[7][6].value = nil
  #     @game.active_player.move = 'castleh1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king' do
  #     @game.board.grid[7][4].value.number_of_moves = 2
  #     @game.board.grid[7][5].value = nil
  #     @game.board.grid[7][6].value = nil
  #     @game.active_player.move = 'castleh1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
  #     @game.board.grid[7][4].value.number_of_moves = 2
  #     @game.board.grid[7][7].value.number_of_moves = 2
  #     @game.board.grid[7][5].value = nil
  #     @game.board.grid[7][6].value = nil
  #     @game.active_player.move = 'castleh1'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the h8 rook and the king are occupied' do
  #     @game.active_player.move = 'castleh8'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns true if the spaces between the h8 rook and the king are unoccupied and it is the first move of the rook and the king' do
  #     @game.board.grid[0][5].value = nil
  #     @game.board.grid[0][6].value = nil
  #     @game.player2_as_active_player
  #     @game.active_player.move = 'castleh8'
  #     expect(@game.castle_check?).to eq true
  #   end

  #   it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the rook' do
  #     @game.board.grid[0][7].value.number_of_moves = 2
  #     @game.board.grid[0][5].value = nil
  #     @game.board.grid[0][6].value = nil
  #     @game.active_player.move = 'castleh8'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king' do
  #     @game.board.grid[0][4].value.number_of_moves = 1
  #     @game.board.grid[0][5].value = nil
  #     @game.board.grid[0][6].value = nil
  #     @game.active_player.move = 'castleh8'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
  #     @game.board.grid[0][4].value.number_of_moves = 3
  #     @game.board.grid[0][7].value.number_of_moves = 1
  #     @game.board.grid[0][5].value = nil
  #     @game.board.grid[0][6].value = nil
  #     @game.active_player.move = 'castleh8'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the a8 rook and the king are occupied' do
  #     @game.board.grid[0][2].value = nil
  #     @game.board.grid[0][3].value = nil
  #     @game.active_player.move = 'castlea8'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns true if the spaces between the a8 rook and the king are unoccupied and it is the first move of the rook and the king' do
  #     @game.board.grid[0][1].value = nil
  #     @game.board.grid[0][2].value = nil
  #     @game.board.grid[0][3].value = nil
  #     @game.player2_as_active_player
  #     @game.active_player.move = 'castlea8'
  #     expect(@game.castle_check?).to eq true
  #   end

  #   it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the rook' do
  #     @game.board.grid[0][0].value.number_of_moves = 2
  #     @game.board.grid[0][1].value = nil
  #     @game.board.grid[0][2].value = nil
  #     @game.board.grid[0][3].value = nil
  #     @game.active_player.move = 'castlea8'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king' do
  #     @game.board.grid[0][4].value.number_of_moves = 21
  #     @game.board.grid[0][1].value = nil
  #     @game.board.grid[0][2].value = nil
  #     @game.board.grid[0][3].value = nil
  #     @game.active_player.move = 'castlea8'
  #     expect(@game.castle_check?).to eq false
  #   end

  #   it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
  #     @game.board.grid[0][4].value.number_of_moves = 2
  #     @game.board.grid[0][0].value.number_of_moves = 21
  #     @game.board.grid[0][1].value = nil
  #     @game.board.grid[0][2].value = nil
  #     @game.board.grid[0][3].value = nil
  #     @game.active_player.move = 'castlea8'
  #     expect(@game.castle_check?).to eq false
  #   end
  # end

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

  context '#attack_move?' do
    it 'returns true if the player decides to move a piece to a cell containing an enemy piece' do
      player = double('Player', move: %w[c4 f4], color: 'Black')
      @board.grid[4][2].value = Rook.new('Black')
      @board.grid[4][5].value = WhitePawn.new('White')
      expect(MoveChecks.new(player, @board).attack_move?).to eq true
    end

    it 'returns false if the player decides to move a piece to an empty cell' do
      player = double('Player', move: %w[b6 e3], color: 'Black')
      @board.grid[2][1].value = Queen.new('White')
      expect(MoveChecks.new(player, @board).attack_move?).to eq false
    end
  end

  context '#valid_move?' do
    before do
      @player = double('Player', move: %w[g8 h6], color: 'Black')
      @move_check = MoveChecks.new(@player, Board.new)
    end

    it 'returns true if the remaining move hash contains the destination coordinate' do
      co_ord = 'a4'
      cell_one = double('Cell', co_ord: 'a3', value: nil)
      cell_two = double('Cell', co_ord: 'a4', value: nil)
      move_hash = { 'up' => [cell_one], 'double_up' => [cell_two], 'up_left' => [], 'up_right' => [] }
      expect(@move_check.valid_move?(move_hash, co_ord)).to eq true
    end

    it 'returns false if the remaining move hash does not contain the destination coordinate' do
      co_ord = 'a5'
      cell_one = double('Cell', co_ord: 'a3', value: nil)
      cell_two = double('Cell', co_ord: 'a4', value: nil)
      move_hash = { 'up' => [cell_one], 'double_up' => [cell_two], 'up_left' => [], 'up_right' => [] }
      expect(@move_check.valid_move?(move_hash, co_ord)).to eq false
    end
  end
end
