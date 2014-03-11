class TicTacToe 
  
  X_COORD = ["A", "B", "C"]
  Y_COORD = ["1", "2", "3"]
  
  attr_reader :board
  
  def initialize
    @board = {}
  end
  
  def place_a_marker(coord_string, player)
    x, y = coord_string.split("")
    if coord_valid?(x, y)
      @board[x] ||= {}
      @board[x][y] = player.marker
    end
  end
  
  private
    
  def coord_valid?(x, y)
    within_range?(x, y) && (@board[x] == nil || @board[x][y] == nil)
  end
  
  def within_range?(x, y)
    X_COORD.include?(x) && Y_COORD.include?(y)
  end
  
end