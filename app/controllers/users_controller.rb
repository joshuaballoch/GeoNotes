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
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit User"
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
      flash[:success]="User updated"
    else
      @title = "Edit User"
      render_errors_now(@user)
      render 'edit'
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
