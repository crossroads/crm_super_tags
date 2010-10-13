class AddFieldInfoToCustomfields < ActiveRecord::Migration
  def self.up
    add_column :customfields, :field_info, :string
  end

  def self.down
    remove_column :customfields, :field_info
  end
end
