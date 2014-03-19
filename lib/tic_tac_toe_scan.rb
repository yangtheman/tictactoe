class TicTacToeScan
  
  attr_reader :player, :playable_cells
  
  def initialize(game, player)
    @game = game
    @player = player
    @playable_cells = {}
  end

  def get_playable_cells
    calculate_playable_cells
    @playable_cells
  end
  
  def winner?
    calculate_playable_cells if @playable_cells == {}
    @playable_cells[3] && @playable_cells[3] == []
  end
  
  private
  
  def calculate_playable_cells
    scan_rows
    scan_cols
    scan_diag_w2e
    scan_diag_e2w
  end
  
  def add_to_playable_cells(num, array)
    @playable_cells[num] ||= []
    @playable_cells[num] += array
    @playable_cells[num].uniq!    
  end
  
  def scan_rows
    @game.y_coords.each do |y|
      player_cell_num = 0
      empty_cells = []
      @game.x_coords.each do |x|
        empty_cells << "#{x}#{y}" if @game.empty_cell?(x, y)
        player_cell_num += 1 if @game.player_cell?(x, y, @player)
      end
      add_to_playable_cells(player_cell_num, empty_cells)
    end
  end
  
  def scan_cols
    @game.x_coords.each do |x|
      player_cell_num = 0
      empty_cells = []
      @game.y_coords.each do |y|
        empty_cells << "#{x}#{y}" if @game.empty_cell?(x, y)
        player_cell_num += 1 if @game.player_cell?(x, y, @player)
      end
      add_to_playable_cells(player_cell_num, empty_cells)
    end
  end
  
  def scan_diag_w2e
    player_cell_num = 0
    empty_cells = []
    @game.x_coords.each_with_index do |x, index|
      y = @game.y_coords[index]
      empty_cells << "#{x}#{y}" if @game.empty_cell?(x, y)
      player_cell_num += 1 if @game.player_cell?(x, y, @player)
    end
    add_to_playable_cells(player_cell_num, empty_cells)
  end
  
  def scan_diag_e2w
    player_cell_num = 0
    empty_cells = []
    @game.x_coords.each_with_index do |x, index|
      y = @game.y_coords.reverse[index]
      empty_cells << "#{x}#{y}" if @game.empty_cell?(x, y)
      player_cell_num += 1 if @game.player_cell?(x, y, @player)
    end
    add_to_playable_cells(player_cell_num, empty_cells)
  end
    
end