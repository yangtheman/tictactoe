require_relative './player'
require_relative './tic_tac_toe'
require_relative './tic_tac_toe_scan'
require_relative './tic_tac_toe_print'

class TicTacToeGame
  
  def initialize
    @game = TicTacToe.new
    @cpu = Player.new
    @human = Player.new(false)
  end
        
  def play(do_loop=true)
    print_initial_instruction
    while do_loop
      if human_turn
        human_scan = scan_board(@human)
        break if game_finished?(human_scan)
        
        cpu_scan = scan_board(@cpu)
        cpu_turn(cpu_scan, human_scan)
        print_board
        break if game_finished?(scan_board(@cpu))
      else
        puts "Invalid Move. Please try again."
      end
    end
    play if continue_to_play? 
  end
          
  private
  
  def print_initial_instruction
    puts "Welcome to a Tic-Tac-Toe Game!\nYou are playing against the computer. Try to win."
    puts "CPU marker is #{@cpu.marker}\nYour marker is #{@human.marker}"
    print_board
  end
  
  def scan_board(player)
    TicTacToeScan.new(@game, player)
  end
  
  def print_board
    TicTacToePrint.print_board(@game)
  end
  
  def human_turn
    print "Your Next Move (for example A1 or C3): "
    input = STDIN.gets.chomp().upcase
    @game.place_marker(input, @human)
  end

  def cpu_turn(cpu_scan, human_scan)
    cpu_cell = calculate_cpu_cell(cpu_scan, human_scan)
    @game.place_marker(cpu_cell, @cpu)
    puts "CPU put his/her marker on #{cpu_cell}"
  end
      
  def calculate_cpu_cell(cpu_scan, human_scan)
    playable_cells = cpu_scan.get_playable_cells
    to_block = human_scan.get_playable_cells
    
    if playable_cells[2] && playable_cells[2].length > 0
      cpu_cell = playable_cells[2].first
    elsif to_block[2] && to_block[2].length > 0
      cpu_cell = to_block[2].first
    elsif @game.best_cells_left.length > 0
      cpu_cell = @game.best_cells_left.first
    elsif playable_cells[1] && playable_cells[1].length > 0
      cpu_cell = playable_cells[1].first
    else
      cpu_cell = playable_cells[0].first
    end
    cpu_cell
  end
    
  def game_finished?(scan)
    if scan.winner?
      if scan.player == @human
        puts "Congratulations, You Won!"
      else
        puts "Sorry. You Lost!"
      end
      return true
    elsif @game.board_full? 
      puts "Awwwww. No one won! Game is tied!"
      return true
    end
    false
  end
  
  def continue_to_play?
    print "Would you like to play again? (Y or N): "
    if STDIN.gets.chomp() =~ /Y|y/
      @game = TicTacToe.new
      true
    else 
      false
    end
  end
  
end