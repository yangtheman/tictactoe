require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'

describe TicTacToe do
  
  it { should respond_to(:board) }
  
  describe ".new" do
    it "should initialize the board instance variable with empty hash" do
      game = TicTacToe.new
      game.board.should_not be_nil
    end
    
    it "should have X_COORD constant defined" do
      TicTacToe::X_COORDS.should_not be_nil
    end

    it "should have X_COORD constant defined" do
      TicTacToe::Y_COORDS.should_not be_nil
    end
  end
  
  describe "#x_coords" do
    it "should return all x_coords" do
      game = TicTacToe.new
      game.x_coords == TicTacToe::X_COORDS
    end
  end
  
  describe "#y_coords" do
    it "should return all x_coords" do
      game = TicTacToe.new
      game.y_coords == TicTacToe::Y_COORDS
    end
  end

  describe "#place_marker" do
    before do
      @game = TicTacToe.new
      @player = Player.new
      @game.stub(:deduct_from_best_cells)
    end
  
    it "should call deduct_from_best_cells" do
      @game.unstub(:deduct_from_best_cells)
      @game.should_receive(:deduct_from_best_cells)
      @game.place_marker("A1", @player)      
    end
      
    it "should put a marker for a player" do
      @game.place_marker("A1", @player).should_not be_nil
      @game.board["A"]["1"].should == @player
      
      @game.place_marker("C3", @player).should_not be_nil
      @game.board["C"]["3"].should == @player
    end
    
    it "should put a marker for a player even if given coordinates are in low cases" do
      @game.place_marker("a1", @player).should_not be_nil
      @game.board["A"]["1"].should == @player
    end
    
    it "should not put a marker for a player if input is out of range" do
      @game.place_marker("A4", @player).should be_nil
      @game.board["A"].should == {}
    end
  end

  describe "#best_cells_left" do
    before do
      @game = TicTacToe.new
      @player = Player.new
    end
    
    it "should return best available cells left to play" do
      @game.place_marker("A1", @player)
      @game.place_marker("A3", @player)
      @game.best_cells_left.include?("A1").should be_false
      @game.best_cells_left.include?("A3").should be_false  
    end
    
    it "should return empty array if all are taken" do
      @game.place_marker("A1", @player)
      @game.place_marker("A3", @player)
      @game.place_marker("B2", @player)
      @game.place_marker("C1", @player)
      @game.place_marker("C3", @player)
      @game.best_cells_left.should == []
    end
  end
  
  describe "#board_full?" do
    before do
      @game = TicTacToe.new
    end
    
    it "should return false if board is not full" do
      @game.board_full?.should be_false
    end

    it "should return true if board is full" do
      player = Player.new
      @game.x_coords.each do |x|
        @game.y_coords.each do |y|
          coord = "#{x}#{y}"
          @game.place_marker(coord, player)
        end
      end
      @game.board_full?.should be_true
    end
  end
  
  describe "#player_cell?" do
    before do
      @game = TicTacToe.new
      @player1 = Player.new
      @player2 = Player.new
      @game.place_marker("A1", @player1)
      @game.place_marker("A2", @player2)
    end
    
    it "should return true if cell is player cell" do
      @game.player_cell?("A", "1", @player1).should be_true
    end
    
    it "should return false if cell is not player cell" do
      @game.player_cell?("A", "2", @player1).should be_false
      @game.player_cell?("A", "3", @player1).should be_false
    end
  end
  
  describe "#empty_cell?" do
    before do
      @game = TicTacToe.new
      @player1 = Player.new
      @game.place_marker("A1", @player1)
    end
    
    it "should return true if cell is empty cell" do
      @game.empty_cell?("A", "2").should be_true
    end
    
    it "should return false if cell is not empty cell" do
      @game.empty_cell?("A", "1").should be_false
    end
  end
  
  describe "#cell_marker" do
    before do
      @game = TicTacToe.new
      @player1 = Player.new
      @game.place_marker("A1", @player1)
    end
    
    it "should return . if cell is empty cell" do
      @game.cell_marker("A", "2").should == "."
    end
    
    it "should return false if cell is not empty cell" do
      @game.cell_marker("A", "1").should == @player1.marker
    end
  end

end