require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'

describe TicTacToe do
  
  it { should respond_to(:board) }
  
  describe ".new" do
    it "should initialize the board instance variable with empty hash" do
      game = TicTacToe.new
      game.board.should == {}
    end
    
    it "should have X_COORD constant defined" do
      TicTacToe::X_COORD.should_not be_nil
    end

    it "should have X_COORD constant defined" do
      TicTacToe::Y_COORD.should_not be_nil
    end
  end
  
  describe "#place_a_marker" do
    it "should put a marker for a player" do
      game = TicTacToe.new
      player = Player.new
      game.place_a_marker("A1", player)
      game.board["A"]["1"].should == player.marker
      
      game.place_a_marker("C3", player)
      game.board["C"]["3"].should == player.marker
    end
    
    it "should put a marker for a player if input is out of range" do
      game = TicTacToe.new
      player = Player.new
      game.place_a_marker("A4", player)
      game.board["A"].should be_nil
    end
  end

end