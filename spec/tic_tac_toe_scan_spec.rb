require_relative '../lib/tic_tac_toe_scan'
require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'
require 'rspec'

describe TicTacToeScan do
  
  describe ".new" do
    it "should initialize playable_cells instance variable with empty hash" do
      game = TicTacToe.new
      player = Player.new
      scan = TicTacToeScan.new(game, player)
      scan.playable_cells.should == {}
    end
  end
  
  describe "#get_playable_cells" do
    before do
      @game = TicTacToe.new
      @player = Player.new
      @player2 = Player.new
      @scan = TicTacToeScan.new(@game, @player)
    end
    
    it "should call calculate_playable_cells method" do
      @scan.should_receive(:calculate_playable_cells)
      @scan.get_playable_cells
    end
    
    it "should return hash with 0 => all cells if board is empty" do
      playable_cells = @scan.get_playable_cells
      playable_cells[0].size.should == 9
      playable_cells[1].should be_nil
      playable_cells[2].should be_nil
    end
    
    context "if there is only one player cell" do
      before do
        @game.place_marker("A1", @player)
        @game.place_marker("B2", @player2)
        @playable_cells = @scan.get_playable_cells
      end
      
      it "should return hash with 1 => available cells with rows/cols/diagnals with one of player cell" do
        @playable_cells[1].include?("A2").should be_true
        @playable_cells[1].include?("A3").should be_true
        @playable_cells[1].include?("B1").should be_true
        @playable_cells[1].include?("C1").should be_true
        @playable_cells[1].include?("C3").should be_true
      end
      
      it "should not return cells that do not include player cell in rows/cols/diagnals" do
        @playable_cells[1].include?("C2").should be_false
        @playable_cells[1].include?("B2").should be_false
        @playable_cells[1].include?("B3").should be_false
      end
    end
    
    context "if there are two player cells in a row" do
      before do
        @game.place_marker("A1", @player)
        @game.place_marker("A2", @player)
        @game.place_marker("B1", @player)
        @playable_cells = @scan.get_playable_cells
      end
      
      it "should return hash with 2 => available cells with rows/cols/diagnals with two of player cells" do
        @playable_cells[2].include?("A3").should be_true
        @playable_cells[2].include?("C1").should be_true
      end
      
      it "should not return cells that do not include player cell in rows/cols/diagnals" do
        @playable_cells[2].include?("C2").should be_false
        @playable_cells[2].include?("B3").should be_false      
      end
    end
    
    context "if there are three player cells in a row" do
      before do
        @game.place_marker("A1", @player)
        @game.place_marker("A2", @player)
        @game.place_marker("A3", @player)
        @playable_cells = @scan.get_playable_cells
      end
      
      it "should return hash with 3 => []" do
        @playable_cells[3].should == []
      end      
    end
  end  
  
  describe "#winner?" do
    before do
      @game = TicTacToe.new
      @player = Player.new
      @scan = TicTacToeScan.new(@game, @player)      
    end
    
    it "should return false if there are no three player cells in a row" do
      @scan.winner?.should be_false
    end

    it "should return false if there are three player cells in a row" do
      @game.place_marker("A1", @player)
      @game.place_marker("B2", @player)
      @game.place_marker("C3", @player)
      @scan.winner?.should be_true
    end
  end
  
end