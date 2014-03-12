class TicTacToe 
  
  X_COORD = ["A", "B", "C"]
  Y_COORD = ["1", "2", "3"]
  
  attr_reader :board
  
  def initialize
    @board = {}
  end
  
  def place_marker(coord_string, player)
    x, y = coord_string.split("")
    if coord_valid?(x, y)
      @board[x] ||= {}
      @board[x][y] = player.marker
    end
  end
  
  def scan_row(row, player)
    X_COORD.inject([]) do |array, x|
      array << "#{x}#{row}" if player_cell?(x, row, player)
      array
    end
  end
  
  def scan_col(col, player)
    Y_COORD.inject([]) do |array, y|
      array << "#{col}#{y}" if player_cell?(col, y, player)
      array
    end
  end
  
  def scan_diag_w2e(player)
    array = []
    X_COORD.each_with_index do |x, index|
      y = Y_COORD[index]
      array << "#{x}#{y}" if player_cell?(x, y, player)
    end
    array
  end
  
  def scan_diag_e2w(player)
    array = []
    X_COORD.each_with_index do |x, index|
      y = Y_COORD.reverse[index]
      array << "#{x}#{y}" if player_cell?(x, y, player)
    end
    array
  end
  
  private
  
  def player_cell?(x, y, player)
    @board[x] && @board[x][y] == player.marker
  end
    
  def coord_valid?(x, y)
    within_range?(x, y) && (@board[x] == nil || @board[x][y] == nil)
  end
  
  def within_range?(x, y)
    X_COORD.include?(x) && Y_COORD.include?(y)
  end
  
end