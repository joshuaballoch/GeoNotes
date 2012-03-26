class UsersController < ApplicationController
  include ApplicationHelper
  def create
    @user = User.new(params[:user])
    if @user.save 
      redirect_to root_path
      flash[:success]="User Created!"
    else
      render_errors_now(@user)
      render 'pages/home'
    end
  end
  
  def index
    @users = User.all
    @title = "Community"
  end
  
  def show
  end
  
end
