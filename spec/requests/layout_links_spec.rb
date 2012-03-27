require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  it "should have the right links on the nav when signed out" do
    visit root_path
    click_link "Home"
    response.should have_selector('title', :content => "Home")
  end
  
  describe "when signed in" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit root_path
      fill_in :session_username_or_email, :with => @user.email
      fill_in :session_password, :with => @user.password
      click_button
    end
    it "should have the right links on the nav when signed in" do
      visit root_path
      click_link "Home"
      response.should have_selector('title', :content => "Home")
      click_link "New Note"
      response.should have_selector('title', :content => "Create Note")
      click_link "Community"
      response.should have_selector('title', :content => "Community")
      click_link "Sign Out"
      response.should have_selector('title', :content => "Home")
    end
  end
end