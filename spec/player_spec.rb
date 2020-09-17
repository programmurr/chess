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
      output_message = "Player1, enter the 'from' and 'to' coordinates for the piece you want to move.\nEnter the coordinates with a space in the middle e.g. 'a2 a4'\n"
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
      expect { @player.enter_move }.to raise_error(RuntimeError)
    end

    it "rejects a 'from' coordinate beyond the range of the board" do
      $stdin = StringIO.new('a2 a40')
      expect { @player.enter_move }.to raise_error(RuntimeError)
    end

    it 'changes the move attribute to a valid move' do
      expect { @player.enter_move }.to change { @player.move }.from(nil).to(%w[a2 a4])
    end

    it 'changes the move attribute from one move to another move' do
      @player.move = %w[a2 a4]
      $stdin = StringIO.new('a4 b5')
      expect { @player.enter_move }.to change { @player.move }.from(%w[a2 a4]).to(%w[a4 b5])
    end
  end
end
