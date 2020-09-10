# frozen_string_literal: true

require_relative '../lib/player'

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
end
