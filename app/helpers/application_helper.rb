module ApplicationHelper
  def title
    if @title
      return "GeoNotes | #{@title}" 
    else
      return "GeoNotes"
    end
  end
  
  def render_errors(object)
    object.errors.each do |key|
      if object.errors[key].join(" ").split.include? "blank"
        flash[:error] = "#{key.capitalize} can't be blank"
        break
      end
      hash = object.errors[key].join(", ")
      flash[:error] = "#{key.capitalize} #{hash}."
    end
  end
  
  def render_errors_now(object)
    object.errors.each do |key|
      if object.errors[key].join(" ").split.include? "blank"
        flash.now[:error] = "Please fill all fields"
        break
      end
      hash = object.errors[key].join(", ")
      flash.now[:error] = "#{key.capitalize} #{hash}."
    end
  end
end
