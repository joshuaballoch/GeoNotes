class Tagging < ActiveRecord::Base
  
  validates :taggable_type, :presence => true
  validates :taggable_id, :presence => true
  validates :tag_id, :presence => true
  
  belongs_to :taggable, :polymorphic => true
  belongs_to :tag
end
