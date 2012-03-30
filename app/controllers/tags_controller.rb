class TagsController < ApplicationController
  def show 
    @tag = Tag.find(params[:id])
    @notes = @tag.notes
    gon.notes=[]
    @notes.each_with_index do |k, index|
      gon.notes[index] = k.attributes
    end
  end
  
  def index
    @tags = Tag.alphabetical.all
  end
  
end
