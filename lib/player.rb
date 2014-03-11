class Player
  
  attr_reader :marker
  
  def initialize(cpu=true)
    @is_cpu = cpu
    @marker = cpu ? "X" : "O"
  end
  
  def is_cpu?
    @is_cpu
  end
  
end