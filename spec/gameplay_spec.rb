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
      @game.board.grid[7][0].value.first_move = false
      @game.board.grid[7][1].value = nil
      @game.board.grid[7][2].value = nil
      @game.board.grid[7][3].value = nil
      @game.active_player.move = 'castlea1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[7][4].value.first_move = false
      @game.board.grid[7][1].value = nil
      @game.board.grid[7][2].value = nil
      @game.board.grid[7][3].value = nil
      @game.active_player.move = 'castlea1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[7][4].value.first_move = false
      @game.board.grid[7][0].value.first_move = false
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
      @game.board.grid[7][7].value.first_move = false
      @game.board.grid[7][5].value = nil
      @game.board.grid[7][6].value = nil
      @game.active_player.move = 'castleh1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[7][4].value.first_move = false
      @game.board.grid[7][5].value = nil
      @game.board.grid[7][6].value = nil
      @game.active_player.move = 'castleh1'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h1 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[7][4].value.first_move = false
      @game.board.grid[7][7].value.first_move = false
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
      @game.board.grid[0][7].value.first_move = false
      @game.board.grid[0][5].value = nil
      @game.board.grid[0][6].value = nil
      @game.active_player.move = 'castleh8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[0][4].value.first_move = false
      @game.board.grid[0][5].value = nil
      @game.board.grid[0][6].value = nil
      @game.active_player.move = 'castleh8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the h8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[0][4].value.first_move = false
      @game.board.grid[0][7].value.first_move = false
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
      @game.board.grid[0][0].value.first_move = false
      @game.board.grid[0][1].value = nil
      @game.board.grid[0][2].value = nil
      @game.board.grid[0][3].value = nil
      @game.active_player.move = 'castlea8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king' do
      @game.board.grid[0][4].value.first_move = false
      @game.board.grid[0][1].value = nil
      @game.board.grid[0][2].value = nil
      @game.board.grid[0][3].value = nil
      @game.active_player.move = 'castlea8'
      expect(@game.castle_check?).to eq false
    end

    it 'returns false if the spaces between the a8 rook and the king are unoccupied and it is not the first move of the king and not the first move of the rook' do
      @game.board.grid[0][4].value.first_move = false
      @game.board.grid[0][0].value.first_move = false
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
end
