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

  context '#enter_move' do
    before do
      @player = Player.new(1)
      $stdin = StringIO.new('a2 a4')
      @move = %w[a2 a4]
    end

    after do
      $stdin = STDIN
    end

    it "prompts the user to enter a 'from' coordinate and a 'to' coordinate" do
      output_message = "Player1, enter the 'from' and 'to' coordinates for the piece you want to move.\nEnter the coordinates with a space in the middle e.g. 'a2 a4'\n[\"a2\", \"a4\"]\n"
      expect { @player.enter_move }.to output(output_message).to_stdout
    end

    it 'stores the coordinates as an array' do
      expect(@player.enter_move).to eq @move
    end

    it "first value of the array is the 'from' co-ord" do
      expect(@player.enter_move[0]).to eq @move[0]
    end

    it "second value of the array is the 'to' co-ord" do
      expect(@player.enter_move[1]).to eq @move[1]
    end

    it "rejects a 'to' coordinate beyond the range of the board" do
      $stdin = StringIO.new('z2 a4')
      error_message = 'That is not a valid coordinate, please re-enter'
      expect { @player.enter_move }.to raise_error(error_message)
    end

    xit "rejects a 'from' coordinate beyond the range of the board" do
      $stdin = StringIO.new('a2 a40')
      error_message = 'That is not a valid coordinate, please re-enter'
      expect { @player.enter_move }.to raise_error(error_message)
    end

    xit "does not let a player touch the opposing player's piece" do
    end
  end
end
