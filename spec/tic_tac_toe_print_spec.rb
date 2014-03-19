require_relative '../lib/tic_tac_toe_print'
require_relative '../lib/tic_tac_toe'
require_relative '../lib/player'
require 'rspec'

describe TicTacToePrint do

  describe ".print_board" do
    it "should print an empty board with dots if there are no markers" do
      game = TicTacToe.new
      STDOUT.should_receive(:puts).with("  | A | B | C")
      STDOUT.should_receive(:puts).with("1 | . | . | .")
      STDOUT.should_receive(:puts).with("2 | . | . | .")
      STDOUT.should_receive(:puts).with("3 | . | . | .")
      TicTacToePrint.print_board(game)
    end
    
    it "should print an empty board with cells with player's markers" do
      game = TicTacToe.new
      cpu = Player.new
      human = Player.new(false)
      game.place_marker("A1", cpu)
      game.place_marker("A3", human)
      game.place_marker("C1", cpu)
      game.place_marker("C3", human)
      STDOUT.should_receive(:puts).with("  | A | B | C")
      STDOUT.should_receive(:puts).with("1 | #{cpu.marker} | . | #{cpu.marker}")
      STDOUT.should_receive(:puts).with("2 | . | . | .")
      STDOUT.should_receive(:puts).with("3 | #{human.marker} | . | #{human.marker}")
      TicTacToePrint.print_board(game)
    end
  end

end