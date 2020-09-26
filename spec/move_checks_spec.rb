# frozen_string_literal: true

require_relative '../lib/move_checks'

context MoveChecks do
  before do
    @board = Board.new
    @board.set_cell_coordinates
    @board.place_pawns
    @board.place_royalty
  end

  context '#cell_contains_piece?' do
    it 'returns true if the cell contains a piece to be moved' do
      player = double('Player', move: %w[h2 h3])
      expect(MoveChecks.new(player, @board).cell_contains_piece?).to eq true
    end

    it 'returns false if the cell does not contain a piece to be moved' do
      player = double('Player', move: %w[h3 h5])
      expect(MoveChecks.new(player, @board).cell_contains_piece?).to eq false
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

  context '#piece_a_whitepawn?' do
    it 'returns true if the piece to be moved is a white pawn' do
      player = double('Player', move: %w[h2 h4], color: 'White')
      expect(MoveChecks.new(player, @board).piece_a_whitepawn?).to eq true
    end

    it 'returns false if the piece to be moved is not a white pawn' do
      player = double('Player', move: %w[b1 c3], color: 'White')
      expect(MoveChecks.new(player, @board).piece_a_whitepawn?).to eq false
    end
  end

  context '#piece_a_blackpawn?' do
    it 'returns true if the piece to be moved is a black pawn' do
      player = double('Player', move: %w[e7 e6], color: 'Black')
      expect(MoveChecks.new(player, @board).piece_a_blackpawn?).to eq true
    end

    it 'returns false if the piece to be moved is not a black pawn' do
      player = double('Player', move: %w[g8 h6], color: 'Black')
      expect(MoveChecks.new(player, @board).piece_a_blackpawn?).to eq false
    end

    context '#white_pawn_non_attack_filter' do
      before do
        @player = double('Player', move: %w[g8 h6], color: 'Black')
        @move_check = MoveChecks.new(@player, Board.new)
      end

      it 'does not remove cells that have a nil value in front of the white pawn' do
        cell_one = double('Cell', co_ord: 'a3', value: nil)
        cell_two = double('Cell', co_ord: 'a4', value: nil)
        move_hash = { 'up' => [cell_one], 'double_up' => [cell_two], 'up_left' => [], 'up_right' => [] }
        returned_hash = @move_check.white_pawn_non_attack_filter(move_hash)
        expect(returned_hash).to eq move_hash
      end

      it 'removes cells that have a piece directly in front of the white pawn' do
        cell_one = double('Cell', co_ord: 'a3', value: 'Chess Piece')
        cell_two = double('Cell', co_ord: 'a4', value: nil)
        move_hash = { 'up' => [cell_one], 'double_up' => [cell_two], 'up_left' => [], 'up_right' => [] }
        returned_hash = @move_check.white_pawn_non_attack_filter(move_hash)
        expect(returned_hash).to eq({ 'double_up' => [cell_two], 'up' => [], 'up_left' => [], 'up_right' => [] })
      end

      it 'removes cells that have a nil value two spaces in front of the white pawn' do
        cell_one = double('Cell', co_ord: 'a3', value: nil)
        cell_two = double('Cell', co_ord: 'a4', value: 'Chess Piece')
        move_hash = { 'up' => [cell_one], 'double_up' => [cell_two], 'up_left' => [], 'up_right' => [] }
        returned_hash = @move_check.white_pawn_non_attack_filter(move_hash)
        expect(returned_hash).to eq({ 'double_up' => [], 'up' => [cell_one], 'up_left' => [], 'up_right' => [] })
      end
    end

    context '#white_pawn_attack_filter' do
      before do
        @player = double('Player', move: %w[g8 h6], color: 'Black')
        @move_check = MoveChecks.new(@player, Board.new)
      end

      it 'does not remove cells that have enemy pieces present to the diagonals of the pawn' do
        cell_one = double('Cell', co_ord: 'd5', value: nil)
        cell_two = double('Cell', co_ord: 'c5', value: 'Enemy Piece')
        cell_three = double('Cell', co_ord: 'e5', value: 'Enemy Piece')
        move_hash = { 'up' => [cell_one], 'double_up' => [], 'up_left' => [cell_two], 'up_right' => [cell_three] }
        returned_hash = @move_check.white_pawn_attack_filter(move_hash)
        expect(returned_hash).to eq move_hash
      end

      it 'removes cells that do not have enemy pieces present to the diagonals of the pawn' do
        cell_one = double('Cell', co_ord: 'd5', value: nil)
        cell_two = double('Cell', co_ord: 'c5', value: nil)
        cell_three = double('Cell', co_ord: 'e5', value: nil)
        move_hash = { 'up' => [cell_one], 'double_up' => [], 'up_left' => [cell_two], 'up_right' => [cell_three] }
        returned_hash = @move_check.white_pawn_attack_filter(move_hash)
        expect(returned_hash).to eq({ 'double_up' => [], 'up' => [cell_one], 'up_left' => [], 'up_right' => [] })
      end
    end

    context '#black_pawn_non_attack_filter' do
      before do
        @player = double('Player', move: %w[g8 h6], color: 'Black')
        @move_check = MoveChecks.new(@player, Board.new)
      end

      it 'does not remove cells that have a nil value in front of the black pawn' do
        cell_one = double('Cell', co_ord: 'f5', value: nil)
        cell_two = double('Cell', co_ord: 'f6', value: nil)
        move_hash = { 'down' => [cell_one], 'double_down' => [cell_two], 'down_left' => [], 'down_right' => [] }
        returned_hash = @move_check.black_pawn_non_attack_filter(move_hash)
        expect(returned_hash).to eq move_hash
      end

      it 'removes cells that have an enemy piece directly in front of the black pawn' do
        cell_one = double('Cell', co_ord: 'b6', value: 'Enemy Piece')
        cell_two = double('Cell', co_ord: 'b5', value: nil)
        move_hash = { 'down' => [cell_one], 'double_down' => [cell_two], 'down_left' => [], 'down_right' => [] }
        returned_hash = @move_check.black_pawn_non_attack_filter(move_hash)
        expect(returned_hash).to eq({ 'double_down' => [cell_two], 'down' => [], 'down_left' => [], 'down_right' => [] })
      end

      it 'removes cells that have a nil value two spaces in front of the black pawn' do
        cell_one = double('Cell', co_ord: 'b6', value: nil)
        cell_two = double('Cell', co_ord: 'b5', value: 'Enemy Piece')
        move_hash = { 'down' => [cell_one], 'double_down' => [cell_two], 'down_left' => [], 'down_right' => [] }
        returned_hash = @move_check.black_pawn_non_attack_filter(move_hash)
        expect(returned_hash).to eq({ 'double_down' => [], 'down' => [cell_one], 'down_left' => [], 'down_right' => [] })
      end
    end

    context '#white_pawn_attack_filter' do
      before do
        @player = double('Player', move: %w[g8 h6], color: 'Black')
        @move_check = MoveChecks.new(@player, Board.new)
      end

      it 'does not remove cells that have enemy pieces present to the diagonals of the pawn' do
        cell_one = double('Cell', co_ord: 'f6', value: nil)
        cell_two = double('Cell', co_ord: 'e6', value: 'Enemy Piece')
        cell_three = double('Cell', co_ord: 'g6', value: 'Enemy Piece')
        move_hash = { 'down' => [cell_one], 'double_down' => [], 'down_left' => [cell_two], 'down_right' => [cell_three] }
        returned_hash = @move_check.black_pawn_attack_filter(move_hash)
        expect(returned_hash).to eq move_hash
      end

      it 'removes cells that do not have enemy pieces present to the diagonals of the pawn' do
        cell_one = double('Cell', co_ord: 'f6', value: nil)
        cell_two = double('Cell', co_ord: 'e6', value: nil)
        cell_three = double('Cell', co_ord: 'g6', value: nil)
        move_hash = { 'down' => [cell_one], 'double_down' => [], 'down_left' => [cell_two], 'down_right' => [cell_three] }
        returned_hash = @move_check.black_pawn_attack_filter(move_hash)
        expect(returned_hash).to eq({ 'double_down' => [], 'down' => [cell_one], 'down_left' => [], 'down_right' => [] })
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

  # context '#permit_special_move?' do
  #   xit 'lets a white pawn move forward 2 spaces on its first move' do
  #     player = double('Player', move: %w[f2 f4], color: 'White')
  #     expect(MoveChecks.new(player, @board).permit_special_move?).to eq true
  #   end
  # end

  # context '#piece_blocking_path?' do
  #   xit 'returns true if there is an enemy piece blocking the move' do
  #   end

  #   xit 'returns true if there is a friendly piece blocking the move' do
  #   end

  #   xit 'returns false if the path of the move is clear' do
  #   end
  # end
end

# For the 'must not jump over another piece' problem:
#   Generate all possible moves as before
#   Start with the last element
#   Is that the end cell?
#   If not, remove it
#   Keep going until the end cell is reached
#   Do any of the other cells have a value that is not nil?
#   If yes, the move cannot be executed
