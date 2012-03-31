require 'spec_helper'

describe TagsController do
   
  describe "GET 'index'" do
    before(:each) do 
        @user = FactoryGirl.create(:user)
        test_sign_in(@user)
        @attr = {:content => "This is an example note.", :user_id => @user.id, :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
        @note = @user.notes.build(@attr)
        @note.save
        @note.reload
    end
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    
    it "should be unsuccessful in reaching index when signed out" do
      test_sign_out 
      get 'index'
      response.should_not be_success
    end
  end
  
  describe "GET 'show'" do
    before(:each) do 
        @user = FactoryGirl.create(:user)
        test_sign_in(@user)
        @attr = {:content => "This is an example note.", :user_id => @user.id, :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
        @note = @user.notes.build(@attr)
        @note.save
        @note.reload
    end
    it "should be successful" do
      @tag = @note.tags.first
      get 'show', :id => @tag.id
      response.should be_success
    end
    it "should be unsuccessful in reaching show if signed out" do
      test_sign_out
      @tag = @note.tags.first
      get 'show', :id => @tag.id
      response.should_not be_success
    end
  end
  
end
