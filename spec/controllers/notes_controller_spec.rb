require 'spec_helper'

describe NotesController do
  render_views 
  
  describe "non-user failures" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @real = {:content => "This is an example note.", :user_id => @user.id, :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
      @attr = {:content => "This is an example note.", :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
    end
    it "should not allow non-users to create notes" do
      lambda do 
        post :create, :note => @attr
      end.should_not change(Note, :count)
    end
  end
  describe "non-user failures2" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @attr = {:content => "This is an example note.", :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
      @note = @user.notes.build(@attr)
      @note.save
    end
    it "should not allow non-users to access notes of users" do
      get 'show', :id => @note.id
      response.should redirect_to(root_path)
    end
    it "should not allow non-users to edit notes of users" do
      @attr[:content] = "New stuff here"
      put :update, :id => @note.id, :note => @attr
      @note.reload
      @note.content.should_not == @attr[:content]
    end
    it "should not allow non-users to destroy notes of users" do
      lambda do
        put :destroy, :id => @note.id
      end.should_not change(Note, :count)
    end
    it "should not allow non-users to access new note page" do
      get 'new'
      response.should redirect_to(root_path)
    end
    it "should not allow non-users to access note editing pages" do
      get 'edit', :id => @note.id
      response.should redirect_to(root_path)
    end
  end
  describe "failures" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      @attr = {:content => "This is an example note.", :user_id => @user.id, :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
      @note = @user.notes.build(@attr)
      @note.save
      @user2 = FactoryGirl.create(:user, :username => FactoryGirl.generate(:username), :email => FactoryGirl.generate(:email))
      test_sign_in(@user2)
    end
    
    it "should not allow users to edit each others' notes" do 
      @attr[:content] = "New content"
      put :update, :id => @note.id, :note => @attr
      @note.reload
      @note.content.should_not == @attr[:content]
      response.should redirect_to(root_path)
    end
    
    it "should not allow users to destroy each others' notes" do 
      lambda do 
        put :destroy, :id => @note.id
      end.should_not change(Note, :count).by(-1)
    end
  end
  
  describe "create success" do 
    before(:each) do 
      @user = FactoryGirl.create(:user)
      @attr = {:content => "This is an example note.", :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
    end
    it "should allow users to create notes" do
      test_sign_in(@user)
      lambda do
        put :create, :note => @attr
        response.should redirect_to(root_path)
      end.should change(Note, :count)
    end
    it "should relate the note to its tags" do
    end
  end
  
  describe "edit update success" do 
    before(:each) do 
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
      @attr = {:content => "This is an example note.", :user_id => @user.id, :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
      @note = @user.notes.build(@attr)
      @note.save
    end
    it "should allow users to update/edit their notes" do
      @attr[:content] = "this is a new content"
      put :update, :id => @note.id, :note => @attr
      @note.reload
      @note.content.should == @attr[:content]
    end
    
    it "should allow users to destroy their notes" do 
      lambda do
        put :destroy, :id => @note.id
        response.should redirect_to root_path
      end.should change(Note, :count).by(-1)
    end
  end
  
  describe "views - show page" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
      @attr = {:content => "This is an example note.", :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
      @note = @user.notes.build(@attr)
      @note.save
    end
    it "should display the note content" do 
      get 'show', :id => @note.id
      response.should have_selector("section", :content => @note.content)
    end
    it "should display the note's tags" do
      get 'show', :id => @note.id
      @note.tags.each do |k|
        response.should have_selector("section", :content => "#{k.name}")
      end
    end
    it "should display a link to the edit page" do
      get 'show', :id => @note.id
      response.should have_selector("a", :content =>"edit")
    end
  end
  describe "views - edit page" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
      @attr = {:content => "This is an example note.", :tag_list => "Tagname1, Tagname2", :latitude => 45.52, :longitude => -73.57801}
      @note = @user.notes.build(@attr)
      @note.save
    end
    it "should have a form" do
      get 'edit', :id => @note.id
      response.should have_selector("form", :class => "edit_note")
    end
    it "should display have a form with the note content" do 
      get 'edit', :id => @note.id
      response.should have_selector("#note_content", :content => @note.content)
    end
    it "should have an input for tags" do
      get 'edit', :id => @note.id
      response.should have_selector("input", :id => "note_tag_list")
    end
  end
  describe "views - new note page" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
      test_sign_in(@user)
      @attr = {:content => "This is an example note."}
    end
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    it "should have the right title" do
      get 'new'
      response.should have_selector("title", :content => "Create Note")
    end
    it "should have an input for the note content" do
      get 'new'
      response.should have_selector("textarea", :id => "note_content")
    end
    it "should have an input for tags" do
      get 'new'
      response.should have_selector("input", :id => "note_tag_list")
    end
  end
end
