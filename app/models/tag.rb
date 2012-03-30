class Tag < ActiveRecord::Base
  validates :name, :presence => true
  has_many :taggings
  has_many :notes, :through => :taggings, :source => :taggable, :source_type => "Note"
  scope :alphabetical, order("name ASC")
end
