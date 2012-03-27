class PagesController < ApplicationController

  def home
    @title = "Home"
    @user = User.new
  end
  
end
