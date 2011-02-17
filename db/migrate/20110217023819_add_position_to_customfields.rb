class AddPositionToCustomfields < ActiveRecord::Migration
  def self.up
    add_column :customfields, :position, :integer
  end

  def self.down
    remove_column :customfields, :position
  end
end
