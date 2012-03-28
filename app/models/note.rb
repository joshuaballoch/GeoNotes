class Note < ActiveRecord::Base
  attr_accessor :tag_list
  attr_accessible :content, :tag_list
  
  validates :content, :presence => true
  validates :user_id, :presence => true
  validates :tag_list, :presence => true
  
  belongs_to :user
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
  
  before_save :save_tags
  
  private
    def save_tags
      self.tags = tag_list.split(/\s*,\s*/).uniq.map do |name|
              Tag.find_or_create_by_name(name)
      end
    end
end
