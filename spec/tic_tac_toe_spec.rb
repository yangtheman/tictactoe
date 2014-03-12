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
  
  describe "#place_marker" do
    it "should put a marker for a player" do
      game = TicTacToe.new
      player = Player.new
      game.place_marker("A1", player)
      game.board["A"]["1"].should == player.marker
      
      game.place_marker("C3", player)
      game.board["C"]["3"].should == player.marker
    end
    
    it "should put a marker for a player if input is out of range" do
      game = TicTacToe.new
      player = Player.new
      game.place_marker("A4", player)
      game.board["A"].should be_nil
    end
  end

  describe "#scan_row" do
    it "should return coordinate with player's markers" do
      game = TicTacToe.new
      player = Player.new
      game.place_marker("A1", player)
      game.place_marker("B1", player)
      game.scan_row("1", player).should == ["A1", "B1"]
      game.scan_row("2", player).should == []
    end
  end
  
  describe "#scan_col" do
    it "should return coordinate with player's markers" do
      game = TicTacToe.new
      player = Player.new
      game.place_marker("C1", player)
      game.place_marker("C3", player)
      game.scan_col("C", player).should == ["C1", "C3"]
      game.scan_col("A", player).should == []      
    end
  end
  
  describe "#scan_diag_w2e" do
    it "should return coordinate with player's markers" do
      game = TicTacToe.new
      player = Player.new
      game.place_marker("A1", player)
      game.place_marker("C3", player)
      game.scan_diag_w2e(player).should == ["A1", "C3"]
    end
  end

  describe "#scan_diag_e2w" do
    it "should return coordinate with player's markers" do
      game = TicTacToe.new
      player = Player.new
      game.place_marker("A3", player)
      game.place_marker("C1", player)
      game.scan_diag_e2w(player).should == ["A3", "C1"]
    end
  end

end