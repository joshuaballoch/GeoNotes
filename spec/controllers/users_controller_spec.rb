require 'spec_helper'

describe UsersController do
  render_views
  
  before(:each) do
    @base_title = "GeoNotes"
  end
  
  describe "GET 'index'" do 
    it "should be successful" do
      get 'index'
      response.should be_success
    end
    it "should have the right @title" do
      get 'index'
      response.should have_selector("title",
                              :content => 
                                        @base_title + " | Community")
    end
  end
  
  describe "failure in creating user with no attributes" do
    before(:each) do
       @attr= { :username => "", 
                :email => "", 
                :password => "", 
                :password_confirmation => "" }
     end
     
     it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end
    
      it "should render the homepage" do
        post :create, :user => @attr
        response.should render_template('/')
      end
  end
  
  describe "failure in creating users with same email" do
    before(:each) do
      @attr1 = { :username => "firstname",
                :email => "doesntmatter@mail.com",
                :password => "password1",
                :password_confirmation => "password1"}
      @attr2 = { :username => "secondname",
                :email => "doesntmatter@mail.com",
                :password => "password1",
                :password_confirmation => "password1"}
    end
    it "should create the first user but not the second" do 
      lambda do 
        post :create, :user => @attr1
      end.should change(User, :count)
      lambda do 
        post :create, :user => @attr2
      end.should_not change(User, :count)
    end
  end
  
  describe "failure in creating users with same username" do
    before(:each) do
      @attr1 = { :username => "firstname",
                :email => "doesntmatter@mail.com",
                :password => "password1",
                :password_confirmation => "password1"}
      @attr2 = { :username => "firstname",
                :email => "newemail@mail.com",
                :password => "password1",
                :password_confirmation => "password1"}
    end
    it "should create the first user but not the second" do 
      lambda do 
        post :create, :user => @attr1
      end.should change(User, :count)
      lambda do 
        post :create, :user => @attr2
      end.should_not change(User, :count)
    end
  end
  
  describe "success" do
    before(:each) do
      @attr = { :username => "woweee123",
                :email => "email@mail.com", 
                :password => "password123",
                :password_confirmation => "password123"}
    end
    
    it "should create the user" do
      lambda do 
        post :create, :user => @attr
      end.should change(User, :count)
    end
    
    it "should redirect to a user show page after creation" do
      lambda do
        post :create, :user => @attr
      end.should redirect_to(user_path(assigns(:user)))
    end    
  end
  
  describe "show user" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
    end
    
    it "should show the user page" do
      get 'show', :id => @user
      response.should be_success
    end
  end
  
  describe "editing tests" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
    end
    
    it "should load the edit page" do
      get 'edit', :id => @user
      response.should be_success
    end
    
    it "should have the right title on the edit page" do
      get 'edit', :id => @user
      response.should have_selector(:title, :content => "Edit User")
    end
  end
  
  describe "test UPDATE" do
    before(:each) do 
      @user = FactoryGirl.create(:user)
    end
    
    describe "in failure to update" do
      before(:each) do 
        @attr = {:username => "", :email => "", :password => "", :password_confirmation => ""}
      end
      
      it "should render the 'edit' page" do 
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end
      
      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        response.should have_selector('title', :content => "Edit User")
      end
    end
    
    describe "in success to update" do
      before(:each) do 
        @attr = {:username => "newname", :email => "newemail@email.com", :password => "password1", :password_confirmation => "password1"}
      end

      it "should change the user's attributes" do 
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.username.should == @attr[:username]
        @user.email.should == @attr[:email]
        @user.encrypted_password.should == assigns(:user).encrypted_password
      end

    end
  end
end
