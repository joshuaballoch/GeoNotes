class AddLocationToNotes < ActiveRecord::Migration
  def self.up
    add_column :notes, :latitude, :float
    add_column :notes, :longitude, :float
  end

  def self.down
    remove_column :notes, :latitude
    remove_column :notes, :longitude
  end
end
