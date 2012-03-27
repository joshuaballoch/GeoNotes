require 'spec_helper'

describe SessionsController do
  render_views 
  
  describe "sign in errors test" do
    before(:each) do
      @attr = { :username_or_email => "woweee123",
                :email => "email@mail.com"}
    end
    it "should render the new page" do 
      post :create, :session => @attr
      response.should render_template('new')
    end
    it "should have the right title" do
      post :create, :session => @attr
      response.should have_selector("title", :content => "Sign In")
    end
    it "should give an error message"do
      post :create, :session => @attr
      flash.now[:error].should =~ /invalid/i
    end
  end
  
  describe "signin success" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @attr = { :username_or_email => @user.username,
                :password => @user.password}
    end
    it "should sign in a user that does exist" do
      post :create, :session => @attr
      controller.current_user.should == @user
      controller.should be_signed_in
    end
    it "should redirect to the user page" do
      post :create, :session => @attr
      response.should redirect_to(user_path(@user))
    end
  end
  
  describe "signout success" do 
    it "should sign out a user that clicks the sign out link" do 
    end
  end
end
