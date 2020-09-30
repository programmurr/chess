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
end
