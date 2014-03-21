require_relative '../lib/player'
require_relative '../lib/tic_tac_toe_game'
require 'rspec'

describe TicTacToeGame do
  
  before do
    @game = TicTacToeGame.new
  end
  
  describe "#print_board" do
    it "should call print_board method of TicTacToePrint class with a TicTacToe instance" do
      TicTacToePrint.should_receive(:print_board).with(an_instance_of(TicTacToe))
      @game.print_board
    end
  end

  describe "#scan_board" do
    it "should instantiate TicTacToeScan with a TicTacToe instance and a Player instance" do
      player = Player.new
      TicTacToeScan.should_receive(:new).with(an_instance_of(TicTacToe), player)
      @game.scan_board(player)
    end
  end
  
  describe "#play" do
    before do
      @game.stub(:print_initial_instruction)
      @game.stub(:interact_with_human)
      @game.stub(:continue_to_play?).and_return(false)
    end
    
    it "should call print_initial_instruction method" do
      @game.unstub(:print_initial_instruction)
      @game.should_receive(:print_initial_instruction).exactly(:once)
      @game.play
    end

    it "should call interact_with_human method " do
      @game.unstub(:interact_with_human)
      @game.should_receive(:interact_with_human).exactly(:once)
      @game.play
    end
    
    it "should call continue_to_play? method" do
      @game.unstub(:continue_to_play?)
      @game.should_receive(:continue_to_play?).exactly(:once).and_return(false)
      @game.play
    end
  end
  
end