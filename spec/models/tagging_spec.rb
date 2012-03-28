require 'spec_helper'

describe Tagging do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @note_attr = {:content => "this is a note."}
    @note = @user.notes.create!(@note_attr)
    @note.save
    @tag = Tag.new(:name => "Tagnameisthis")
    @tag.save
    @attr = {:taggable_type => "Note", :taggable_id => @note.id, :tag_id => @tag.id}
  end
  
  it "should create a new tagging" do
    Tagging.new(@attr).save
  end
  
  describe "tagging associations" do
    before(:each) do
      @tagging = Tagging.new(@attr)
      @tagging.save
    end
    it "should have a taggable attribute" do
      @tagging.should respond_to(:taggable)
    end
    it "should relate to its taggable item" do
      @tagging.taggable.should == @note
      @tagging.taggable_id.should == @note.id
      @tagging.taggable_type.should == @note.class.name
    end
    it "should have a tag attribute" do
      @tagging.should respond_to(:tag)
    end
    it "should relate to its tag" do
      @tagging.tag_id.should == @tag.id
      @tagging.tag.should == @tag
    end
    it "should have note relate back to it" do
      @note.reload
      @note.taggings.include?(@tagging).should == true
    end
    it "should have tag relate back to it" do
      @tag.reload
      @tag.taggings.include?(@tagging).should == true
    end
  end
  
  describe "validations" do
    it "should require the taggable attributes" do
      Tagging.new(:tag_id => 1).should_not be_valid
    end
    
    it "should require a tag attribute" do
      Tagging.new(:taggable_type => "Note", :taggable_id => 2).should_not be_valid      
    end   
  end
end
