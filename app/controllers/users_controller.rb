class UsersController < ApplicationController
  def create
    @user = User.new(params[:user])
    if @user.save 
      redirect_to root_path
      flash[:success]="User Created!"
    else
      render 'home'
    end
  end
end
