class SessionsController < ApplicationController
  
  def new
    @title = "Sign In"
  end
  
  def create
    user = User.authenticate((params[:session][:username_or_email]).downcase,
                              params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign In"
      render 'sessions/new'
    else
      sign_in user
      redirect_to root_path
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
  
end
