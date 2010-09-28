class AddCustomfieldsFormFieldType < ActiveRecord::Migration
  def self.up
    add_column :customfields, :form_field_type, :string
  end

  def self.down
    remove_column :customfields, :form_field_type
  end
end
