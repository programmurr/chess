# # frozen_string_literal: true

require 'pry'
require_relative '../lib/gameplay'

describe GamePlay do
  context '#castle_check?' do
    before do
      @game = GamePlay.new
      @game.setup_board
      @game.assign_player1_white_piece
      @game.player1_as_active_player
    end

    it 'returns false if the spaces between the a1 rook and the king are occupied' do
      @game.board.grid[7][2].value = nil
      @game.board.grid[7][3].value = nil
      @game.active_player.move = 'castlea1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns true if the spaces between the a1 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @game.board.grid[7][1].value = nil
      @game.board.grid[7][2].value = nil
      @game.board.grid[7][3].value = nil
      @game.active_player.move = 'castlea1'
      expect(@game.castle_check?).to eq true
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the rook' do
      @game.board.grid[7][0].value.number_of_moves = 2
      @game.board.grid[7][1].value = nil
      @game.board.grid[7][2].value = nil
      @game.board.grid[7][3].value = nil
      @game.active_player.move = 'castlea1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[7][4].value.number_of_moves = 2
      @game.board.grid[7][1].value = nil
      @game.board.grid[7][2].value = nil
      @game.board.grid[7][3].value = nil
      @game.active_player.move = 'castlea1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[7][4].value.number_of_moves = 1
      @game.board.grid[7][0].value.number_of_moves = 1
      @game.board.grid[7][1].value = nil
      @game.board.grid[7][2].value = nil
      @game.board.grid[7][3].value = nil
      @game.active_player.move = 'castlea1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are occupied' do
      @game.active_player.move = 'castleh1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns true if the spaces between the h1 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @game.board.grid[7][5].value = nil
      @game.board.grid[7][6].value = nil
      @game.active_player.move = 'castleh1'
      expect(@game.castle_check?).to eq true
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the rook' do
      @game.board.grid[7][7].value.number_of_moves = 2
      @game.board.grid[7][5].value = nil
      @game.board.grid[7][6].value = nil
      @game.active_player.move = 'castleh1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[7][4].value.number_of_moves = 2
      @game.board.grid[7][5].value = nil
      @game.board.grid[7][6].value = nil
      @game.active_player.move = 'castleh1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[7][4].value.number_of_moves = 2
      @game.board.grid[7][7].value.number_of_moves = 2
      @game.board.grid[7][5].value = nil
      @game.board.grid[7][6].value = nil
      @game.active_player.move = 'castleh1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are occupied' do
      @game.active_player.move = 'castleh8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns true if the spaces between the h8 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @game.board.grid[0][5].value = nil
      @game.board.grid[0][6].value = nil
      @game.player2_as_active_player
      @game.active_player.move = 'castleh8'
      expect(@game.castle_check?).to eq true
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the rook' do
      @game.board.grid[0][7].value.number_of_moves = 2
      @game.board.grid[0][5].value = nil
      @game.board.grid[0][6].value = nil
      @game.active_player.move = 'castleh8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[0][4].value.number_of_moves = 1
      @game.board.grid[0][5].value = nil
      @game.board.grid[0][6].value = nil
      @game.active_player.move = 'castleh8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[0][4].value.number_of_moves = 3
      @game.board.grid[0][7].value.number_of_moves = 1
      @game.board.grid[0][5].value = nil
      @game.board.grid[0][6].value = nil
      @game.active_player.move = 'castleh8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are occupied' do
      @game.board.grid[0][2].value = nil
      @game.board.grid[0][3].value = nil
      @game.active_player.move = 'castlea8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns true if the spaces between the a8 rook and the king are unoccupied and it is the first move of the rook and the king' do
      @game.board.grid[0][1].value = nil
      @game.board.grid[0][2].value = nil
      @game.board.grid[0][3].value = nil
      @game.player2_as_active_player
      @game.active_player.move = 'castlea8'
      expect(@game.castle_check?).to eq true
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the rook' do
      @game.board.grid[0][0].value.number_of_moves = 2
      @game.board.grid[0][1].value = nil
      @game.board.grid[0][2].value = nil
      @game.board.grid[0][3].value = nil
      @game.active_player.move = 'castlea8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[0][4].value.number_of_moves = 21
      @game.board.grid[0][1].value = nil
      @game.board.grid[0][2].value = nil
      @game.board.grid[0][3].value = nil
      @game.active_player.move = 'castlea8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[0][4].value.number_of_moves = 2
      @game.board.grid[0][0].value.number_of_moves = 21
      @game.board.grid[0][1].value = nil
      @game.board.grid[0][2].value = nil
      @game.board.grid[0][3].value = nil
      @game.active_player.move = 'castlea8'
      expect(@game.castle_check?).to eq false
    end
  end

  context '#promote_pawn?' do
    before do
      @game = GamePlay.new
      @game.setup_board
      @game.assign_player1_white_piece
      @game.player1_as_active_player
    end

    it 'returns true if there is a WhitePawn present on board row 0' do
      @game.board.grid[0][0].value = nil
      @game.board.grid[1][0].value = WhitePawn.new('White')
      @game.active_player.move = %w[a7 a8]
      @game.player_move_actions
      expect(@game.promote_pawn?).to eq true
    end

    it 'returns false if there is not WhitePawn present on board row 0' do
      expect(@game.promote_pawn?).to eq false
    end

    it 'returns true if there is a BlackPawn present on board row 7' do
      @game.player2_as_active_player
      @game.board.grid[7][0].value = nil
      @game.board.grid[6][0].value = BlackPawn.new('Black')
      @game.active_player.move = %w[a2 a1]
      @game.player_move_actions
      expect(@game.promote_pawn?).to eq true
    end

    it 'returns false if there is not BlackPawn present on board row 7' do
      expect(@game.promote_pawn?).to eq false
    end
  end

  context '#execute_promotion' do
    before do
      @game = GamePlay.new
      @game.setup_board
      @game.assign_player1_white_piece
      @game.player1_as_active_player
    end

    after do
      $stdin = STDIN
    end

    it 'can promote a white pawn to a rook' do
      @game.board.grid[0][0].value = WhitePawn.new('White')
      @game.board.grid[1][0].value = nil
      $stdin = StringIO.new('rook')
      @game.active_player.move = %w[a7 a8]
      expect { @game.execute_promotion }.to change { @game.board.grid[0][0].value.class.to_s }.from('WhitePawn'). to('Rook')
    end

    it 'can promote a white pawn to a knight' do
      @game.board.grid[0][2].value = WhitePawn.new('White')
      @game.board.grid[1][2].value = nil
      $stdin = StringIO.new('knight')
      @game.active_player.move = %w[c7 c8]
      expect { @game.execute_promotion }.to change { @game.board.grid[0][2].value.class.to_s }.from('WhitePawn'). to('Knight')
    end

    it 'can promote a white pawn to a queen' do
      @game.board.grid[0][7].value = WhitePawn.new('White')
      @game.board.grid[1][7].value = nil
      $stdin = StringIO.new('queen')
      @game.active_player.move = %w[h7 h8]
      expect { @game.execute_promotion }.to change { @game.board.grid[0][7].value.class.to_s }.from('WhitePawn'). to('Queen')
    end

    it 'can promote a white pawn to a bishop' do
      @game.board.grid[0][5].value = WhitePawn.new('White')
      @game.board.grid[1][5].value = nil
      $stdin = StringIO.new('bishop')
      @game.active_player.move = %w[f7 f8]
      expect { @game.execute_promotion }.to change { @game.board.grid[0][5].value.class.to_s }.from('WhitePawn'). to('Bishop')
    end

    it 'can promote a black pawn to a rook' do
      @game.board.grid[7][0].value = BlackPawn.new('Black')
      @game.board.grid[6][0].value = nil
      $stdin = StringIO.new('rook')
      @game.active_player.move = %w[a2 a1]
      expect { @game.execute_promotion }.to change { @game.board.grid[7][0].value.class.to_s }.from('BlackPawn'). to('Rook')
    end

    it 'can promote a black pawn to a knight' do
      @game.board.grid[7][2].value = BlackPawn.new('Black')
      @game.board.grid[6][2].value = nil
      $stdin = StringIO.new('knight')
      @game.active_player.move = %w[c2 c1]
      expect { @game.execute_promotion }.to change { @game.board.grid[7][2].value.class.to_s }.from('BlackPawn'). to('Knight')
    end

    it 'can promote a black pawn to a queen' do
      @game.board.grid[7][7].value = BlackPawn.new('Black')
      @game.board.grid[6][7].value = nil
      $stdin = StringIO.new('queen')
      @game.active_player.move = %w[h2 h1]
      expect { @game.execute_promotion }.to change { @game.board.grid[7][7].value.class.to_s }.from('BlackPawn'). to('Queen')
    end

    it 'can promote a black pawn to a bishop' do
      @game.board.grid[7][5].value = BlackPawn.new('Black')
      @game.board.grid[6][5].value = nil
      $stdin = StringIO.new('bishop')
      @game.active_player.move = %w[f2 f1]
      expect { @game.execute_promotion }.to change { @game.board.grid[7][5].value.class.to_s }.from('BlackPawn'). to('Bishop')
    end
  end

  context '#en_passant_actions' do
    before do
      @game = GamePlay.new
      @game.setup_board
      @game.assign_player1_white_piece
    end

    it 'allows the white player to execute an en passant move when opposing pawns are adjascent, one of which completed a double jump first move' do
      @game.board.grid[3][0].value = WhitePawn.new('White')
      @game.board.grid[3][0].value.number_of_moves = 2
      @game.player2_as_active_player
      @game.active_player.move = %w[b7 b5]
      @game.player_move_actions
      @game.en_passant_actions
      @game.switch_active_player
      @game.active_player.move = %w[a5 b6]
      expect {@game.player_move_actions }.to change { @game.board.grid[3][1].value.class }.from(BlackPawn). to(NilClass)
    end

    it 'allows the black player to execute an en passant move when opposing pawns are adjascent, one of which completed a double jump first move' do
      @game.board.grid[4][6].value = BlackPawn.new('Black')
      @game.board.grid[4][6].value.number_of_moves = 2
      @game.player1_as_active_player
      @game.active_player.move = %w[f2 f4]
      @game.player_move_actions
      @game.en_passant_actions
      @game.switch_active_player
      @game.active_player.move = %w[g4 f3]
      expect {@game.player_move_actions }.to change { @game.board.grid[4][5].value.class }.from(WhitePawn). to(NilClass)
    end

    it 'does not allow the white player to execute an en passant move when opposing pawns are adjascent with more than 1 move completed' do
      @game.board.grid[3][0].value = WhitePawn.new('White')
      @game.board.grid[3][0].value.number_of_moves = 2
      @game.board.grid[2][1].value = BlackPawn.new('Black')
      @game.board.grid[2][1].value.number_of_moves = 1
      @game.player2_as_active_player
      @game.active_player.move = %w[b6 b5]
      @game.player_move_actions
      @game.en_passant_actions
      @game.switch_active_player
      @game.active_player.move = %w[a5 b6]
      expect {@game.player_move_actions }.not_to change { @game.board.grid[3][1].value.class }
    end

    it 'does not allow the black player to execute an en passant move when opposing pawns are adjascent with more than 1 move completed' do
      @game.board.grid[4][6].value = BlackPawn.new('Black')
      @game.board.grid[4][6].value.number_of_moves = 2
      @game.board.grid[5][5].value = WhitePawn.new('White')
      @game.board.grid[5][5].value.number_of_moves = 1
      @game.player1_as_active_player
      @game.active_player.move = %w[f3 f4]
      @game.player_move_actions
      @game.en_passant_actions
      @game.switch_active_player
      @game.active_player.move = %w[g4 f3]
      expect {@game.player_move_actions }.not_to change { @game.board.grid[4][5].value.class }
    end

    it 'does not raise errors with other pieces on the black en passant row' do
      @game.board.grid[3][0].value = WhitePawn.new('White')
      @game.board.grid[3][0].value.number_of_moves = 2
      @game.board.grid[3][4].value = Knight.new('White')
      @game.board.grid[3][7].value = Knight.new('Black')
      @game.player2_as_active_player
      @game.active_player.move = %w[b7 b5]
      @game.player_move_actions
      @game.en_passant_actions
      @game.switch_active_player
      @game.active_player.move = %w[a5 b6]
      expect {@game.player_move_actions }.to change { @game.board.grid[3][1].value.class }.from(BlackPawn). to(NilClass)
    end

    it 'does not raise errors with other pieces on the white en passant row' do
      @game.board.grid[4][6].value = BlackPawn.new('Black')
      @game.board.grid[4][6].value.number_of_moves = 2
      @game.board.grid[4][2].value = Rook.new('Black')
      @game.board.grid[4][0].value = Queen.new('White')
      @game.player1_as_active_player
      @game.active_player.move = %w[f2 f4]
      @game.player_move_actions
      @game.en_passant_actions
      @game.switch_active_player
      @game.active_player.move = %w[g4 f3]
      expect {@game.player_move_actions }.to change { @game.board.grid[4][5].value.class }.from(WhitePawn). to(NilClass)
    end
  end
end
