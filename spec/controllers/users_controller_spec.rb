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
end
