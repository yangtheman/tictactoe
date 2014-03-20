class TicTacToePrint
  
  class << self
  
    def print_board(game)
      (0).upto(3) do |row_num|
        if row_num == 0
          puts ([" "] + game.x_coords).join(" | ")
        else
          y_index = row_num -1
          puts ([game.y_coords[y_index]] + get_values_of_row(y_index, game)).join(" | ")
        end
      end
    end
    
    def get_values_of_row(y_index, game)
      row = game.y_coords[y_index]
      game.x_coords.inject([]) do |array, x|
        array << game.cell_marker(x, row)
        array
      end
    end

  end
  
end