require 'spec_helper'

describe Note do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = {:content => "This is an example note.", :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
  end
  it "should create a new note" do
    @user.notes.create!(@attr)
  end
  describe "notes associations" do
    before(:each) do 
      @note = @user.notes.create!(@attr)
    end
    it "should have a user attribute" do
      @note.should respond_to(:user)
    end
    it "should relate to its creator" do
      @note.user_id.should == @user.id
      @note.user.should == @user
    end
    describe "tag associations" do
      before(:each) do 
        @tag = Tag.new(:name =>"name")
        @tag.save
        @note.tag_list ="#{@tag.name}"
      end
      it "should be able to have tags" do
        @note.should respond_to(:tags)
      end
      it "should relate to its tags" do
        @note.save.should == true
        @note.tags.include?(@tag).should == true
      end
      it "should have its tags relate back to it" do
        @note.save
        @tag.reload
        @tag.notes.include?(@note).should == true
      end
    end
  end
  
  describe "validations" do
    it "should have a user id" do
      Note.new(@attr).should_not be_valid
    end
    
    it "should require content" do
      @user.notes.build(:content => "  ").should_not be_valid
    end
  end
end
