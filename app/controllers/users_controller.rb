class UsersController < ApplicationController
  include ApplicationHelper
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :authenticate, :except => [:create]
  def create
    @user = User.new(params[:user])
    if @user.save 
      sign_in(@user)
      redirect_to root_path
      flash[:success]="User Created!"
    else
      render_errors_now(@user)
      render 'users/new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @title = "Edit User"
    @notes = @user.notes
      gon.notes=[]
      @notes.each_with_index do |k, index|
        gon.notes[index] = k.attributes
      end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user
      flash[:success]="User updated"
    else
      @title = "Edit User"
      @notes = @user.notes
        gon.notes=[]
        @notes.each_with_index do |k, index|
          gon.notes[index] = k.attributes
        end
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
    @notes = @user.notes
      gon.notes=[]
      @notes.each_with_index do |k, index|
        gon.notes[index] = k.attributes
      end
  end
  
  private
  
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
  
  
  
end
