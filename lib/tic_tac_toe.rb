class TicTacToe
  
  X_COORDS = ["A", "B", "C"]
  Y_COORDS = ["1", "2", "3"]
  
  attr_reader :board
  
  def initialize
    @best_cells = ["B2", "A1", "A3", "C1", "C3"]
    @board = {}
    X_COORDS.each do |x|
      @board[x] = {}
    end
  end
  
  def x_coords
    X_COORDS
  end
  
  def y_coords
    Y_COORDS
  end
  
  def place_marker(coord_string, player)
    x, y = coord_string.upcase.split("")
    return nil unless coord_valid?(x, y)
    deduct_from_best_cells(x, y)
    @board[x][y] = player
  end
  
  def best_cells_left
    @best_cells
  end
  
  def board_full?
    sum = X_COORDS.inject(0) {|sum, x| sum += @board[x].size}
    sum == 9
  end
  
  def player_cell?(x, y, player)
    @board[x][y] == player
  end
  
  def empty_cell?(x, y)
    @board[x][y].nil?
  end
  
  def cell_marker(x, y)
    @board[x][y].nil? ? "." : @board[x][y].marker
  end
  
  private
        
  def coord_valid?(x, y)
    within_range?(x, y) && @board[x][y].nil?
  end
  
  def within_range?(x, y)
    X_COORDS.include?(x) && Y_COORDS.include?(y)
  end
  
  def deduct_from_best_cells(x, y)
    @best_cells -= ["#{x}#{y}"]
  end
  
end