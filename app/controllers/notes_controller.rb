class NotesController < ApplicationController
  include ApplicationHelper
  before_filter :authenticate
  before_filter :correct_user, :only => [:update, :edit, :destroy]
  def create
    @note = current_user.notes.build(params[:note])
    if @note.save
      flash[:success]="Note created!"
      redirect_to root_path
    else
      render_errors_now(@note)
      render 'new'
    end
  end
  
  def update
    @note = Note.find(params[:id])
    if @note.update_attributes(params[:note])
      flash[:success]="Note updated!"
      redirect_to root_path
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
    gon.note = @note.attributes
    gon.current_user = current_user.id
  end
  
  def index
    @title = "My Notes"
    @notes = Note.all
      gon.notes=[]
      @notes.each_with_index do |k, index|
        gon.notes[index] = k.attributes
      end    
  end
  
  def edit
    gon.note = @note.attributes
  end
  
  private
    def correct_user
      @note = Note.find(params[:id])
      redirect_to(root_path) unless current_user?(@note.user)
    end
end
