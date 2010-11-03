class AddSelectOptionsToCustomfields < ActiveRecord::Migration
  def self.up
    add_column :customfields, :select_options, :text
  end

  def self.down
    remove_column :customfields, :select_options
  end
end
