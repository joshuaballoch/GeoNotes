require 'spec_helper'

describe Tag do
  before(:each) do 
    @attr = {:name => "Tagname"}
  end
  
  it "should create a new tag" do
    Tag.new(@attr).save
  end
  
  describe "validations" do
    it "should require a name" do 
      Tag.new.should_not be_valid
    end
  end
end
