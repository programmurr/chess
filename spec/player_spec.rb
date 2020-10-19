# frozen_string_literal: true

require_relative '../lib/player'
require_relative '../lib/piece'

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

    it "has a 'move' attribute set to nil" do
      new_player = Player.new(1)
      expect(new_player.move).to eq nil
    end

    it "has a 'color' attribute set to nil" do
      new_player = Player.new(1)
      expect(new_player.color).to eq nil
    end
  end

  context '#assign_black_piece' do
    it 'can be assigned the BlackPiece class as a piece attribute' do
      new_player = Player.new(1)
      expect { new_player.assign_black_piece }.to change { new_player.color }.from(nil).to 'Black'
    end
  end

  context '#assign_white_piece' do
    it 'can be assigned the WhitePiece class as a piece attribute' do
      new_player = Player.new(1)
      expect { new_player.assign_white_piece }.to change { new_player.color }.from(nil).to 'White'
    end
  end
end
