# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/pieces/black_pieces'
require_relative '../lib/pieces/white_pieces'

describe Player do
  context '#initialize' do
    it 'creates a new player object that can be initialized with the name of Player1' do
      player = double
      allow(player).to receive(:name) { 'Player1' }
      new_player = Player.new(1)
      expect(new_player.name).to eq player.name
    end

    it 'creates a new player object that can be initialized with the name of Player2' do
      player = double
      allow(player).to receive(:name) { 'Player2' }
      new_player = Player.new(2)
      expect(new_player.name).to eq player.name
    end
  end

  context '#assign_black_piece' do
    it 'can be assigned the BlackPiece class as a piece attribute' do
      new_player = Player.new(1)
      expect { new_player.assign_black_piece }.to change { new_player.piece }.from(nil).to be_instance_of BlackPiece
    end
  end

  context '#assign_white_piece' do
    it 'can be assigned the WhitePiece class as a piece attribute' do
      new_player = Player.new(1)
      expect { new_player.assign_white_piece }.to change { new_player.piece }.from(nil).to be_instance_of WhitePiece
    end
  end
end
