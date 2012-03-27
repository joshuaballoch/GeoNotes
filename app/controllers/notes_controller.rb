class NotesController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate
  before_filter :correct_user, :only => [:update, :edit, :destroy]
  def create
    @note = current_user.notes.build(params[:note])
    if @note.save
      flash[:success]="Note created!"
      redirect_to @note
    else
      render_errors_now(@note)
      render 'new'
    end
  end
  
  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      flash[:success]="Note updated!"
      redirect_to @note
    else
      render_errors_now(@note)
      render 'edit'
    end
  end
  
  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to root_path
  end
  
  def new
    @note = Note.new
    @title = "Create Note"
  end
  
  def show
    @title = "My Note"
    @note = Note.find(params[:id])
  end
  
  def edit
  end
  
  private
    def correct_user
      @note = Note.find(params[:id])
      redirect_to(root_path) unless current_user?(@note.user)
    end
end
