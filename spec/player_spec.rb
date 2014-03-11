require_relative '../lib/player'

describe Player do
  
  it { should respond_to(:marker) }
  
  describe ".new" do
    it "should initialize with is_machine instance variable set to true and X marker" do
      player = Player.new
      player.marker.should == "X"
    end
    
    it "should initialize with marker set to O if non-machine" do
      player = Player.new(false)
      player.marker.should == "O"
    end    
  end
  
  describe "#is_cpu?" do
    it "should return true if player is cpu" do
      player = Player.new
      player.is_cpu?.should be_true
    end
    
    it "should return false if player is human (not cpu)" do
      player = Player.new(false)
      player.is_cpu?.should be_false
    end    
  end
  
end