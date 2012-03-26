class UsersController < ApplicationController
  include ApplicationHelper
  def create
    @user = User.new(params[:user])
    if @user.save 
      redirect_to @user
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
    @user = User.find(params[:id])
    @title = @user.username
  end
  
end
