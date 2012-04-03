class PagesController < ApplicationController

  def home
    @title = "Home"
    @user = User.new unless signed_in?
    if signed_in?
      @notes = current_user.notes
      gon.notes=[]
      current_user.notes.each_with_index do |k, index|
        gon.notes[index] = k.attributes
      end    
    end
  end
  
  def about
    
  end
  
  def contact
    
  end
  
end
