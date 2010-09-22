# == Schema Information
# Schema version: 23
#
# Table name: customfields
#
#  id                   :integer(4)      not null, primary key
#  user_id              :integer(4)
#  field_name,          :string(64)
#  field_type,          :string(32)
#  field_label,         :string(64)
#  table_name,          :string(32)
#  display_sequence,    :integer(4)
#  display_block,       :integer(4)
#  display_width,       :integer(4)
#  max_size,            :integer(4)
#  disabled,            :boolean
#  required,            :boolean
#  created_at           :datetime
#  updated_at           :datetime
#

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Customfield do

  before(:each) do
    login
  end

  it "should create a new instance given valid attributes" do
    Customfield.create!(
      :field_name => "skype_address",
      :field_label => "Skype address",
      :field_type => "VARCHAR(255)",
      :max_size => 220,
      :display_sequence => 10,
      :display_block => 10,
      :display_width => 250,
      :user => Factory(:user),
      :tag => Factory(:tag)
    )
  end

  it "should be able to use a form_field_type to set defined values" do
    c = Customfield.new
    c.form_field_type = "number"
    c.field_type.should == "DECIMAL"
    c.display_width.should == 60

    c.form_field_type = "short_answer"
    c.field_type.should == "VARCHAR(255)"
    c.display_width.should == 200
  end
end
