require_relative '../lib/tic_tac_toe_game'
require 'rspec'

describe TicTacToeGame do
  
  before do
    @game = TicTacToeGame.new
  end
  
  describe "#play" do
    it "should call print initial instructions" do
      @game.should_receive(:print_initial_instruction)
      @game.play(nil)
    end
    
    # Not sure what would be the best way to test the whole while loop.... :(
  end

  
end