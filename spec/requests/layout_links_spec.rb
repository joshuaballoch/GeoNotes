require 'spec_helper'

describe "LayoutLinks" do
  it "should have a Home page at '/'" do
    get '/'
    response.should have_selector('title', :content => "Home")
  end
  it "should have the right links on the nav" do
    visit root_path
    click_link "Home"
    response.should have_selector('title', :content => "Home")
    click_link "Community"
    response.should have_selector('title', :content => "Community")
    #Add more nav link tests
  end
end