class Note < ActiveRecord::Base
  attr_accessible :content
  
  validates :content, :presence => true
  validates :user_id, :presence => true
  
  belongs_to :user
  
end
