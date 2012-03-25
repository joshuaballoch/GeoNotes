module ApplicationHelper
  def title
    if @title
      return "GeoNotes | #{@title}" 
    else
      return "GeoNotes"
    end
  end
end
