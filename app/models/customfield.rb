# Fat Free CRM
# Copyright (C) 2008-2009 by Michael Dvorkin
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#------------------------------------------------------------------------------

# == Schema Information
# Schema version: 23
#
# Table name: customfields
#
#  id                   :integer(4)      not null, primary key
#  user_id              :integer(4)
#  tag_id               :integer(4)
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

class Customfield < ActiveRecord::Base
  belongs_to :user
  belongs_to :tag, :class_name => 'ActsAsTaggableOn::Tag'

  FIELD_TYPES = %w[INTEGER DECIMAL FLOAT VARCHAR(255) DATE DATETIME TEXT]

  ## Default validations for model
  #
  validates_presence_of :tag, :message => "^Please specify a Super Tag."

  validates_presence_of :field_name, :message => "^Please enter a Field name."
  validates_format_of :field_name, :with => /\A[A-Za-z_]+\z/, :allow_blank => true, :message => "^Please specify Field name without any special characters or numbers, spaces are not allowed - use [A-Za-z_] "
  validates_length_of :field_name, :maximum => 64, :message => "^The Field name must be less than 64 characters in length."
  validates_uniqueness_of :field_name, :scope => :tag_id, :message => "^The field name must be unique."

  validates_presence_of :field_label, :message => "^Please enter a Field label."
  validates_length_of :field_label, :maximum => 64, :message => "^The Field name must be less than 64 characters in length."

  validates_presence_of :field_type, :message => "^Please specify a Field type."
  validates_inclusion_of :field_type, :in => FIELD_TYPES, :message => "^Hack alert::Field type Please dont change the HTML source of this application."

  validates_presence_of :display_width, :message => "^Please enter a Width."
  validates_presence_of :max_size, :message => "^Please enter a Max Size."

  validates_numericality_of :display_width, :only_integer => true, :allow_blank => true, :message => "^Width can only be whole number."
  validates_numericality_of :max_size, :only_integer => true, :allow_blank => true, :message => "^Max size can only be whole number."

  validates_length_of :display_width, :maximum => 4, :allow_blank => true, :message => "^Width can be 4 numbers long."
  validates_length_of :max_size, :maximum => 4, :allow_blank => true, :message => "^Max size can be 4 numbers long."

  ## TODO - Added for now but need to get simple_column_search working later
  simple_column_search :field_name, :field_label, :table_name, :escape => lambda { |query| query.gsub(/[^\w\s\-\.']/, "").strip }

  SORT_BY = {
    "field name"         => "customfields.field_name ASC",
    "field label"        => "customfields.field_label DESC",
    "field type"         => "customfields.field_type DESC",
    "table"              => "customfields.table_name DESC",
    "display width"      => "customfields.display_width DESC",
    "max size"           => "customfields.max_size DESC",
    "date created"       => "customfields.created_at DESC",
    "date updated"       => "customfields.updated_at DESC"
  }

  after_create :add_column
  after_validation_on_update :update_column

  def tag_class_name
    "Tag#{self.tag_id}" if self.tag_id
  end

  def tag_class
    tag_class_name.try(:constantize)
  end

  def table_name
    tag_class.try(:table_name)
  end

  def add_column
    unless tag_class.columns.map(&:name).include?(self.field_name)
      connection.add_column(self.table_name, self.field_name, self.field_type)
      tag_class.reset_column_information
    end
  end

  def update_column
    if self.errors.empty?
      if self.field_name_changed?
        connection.rename_column(self.table_name, self.field_name_was, self.field_name)
        tag_class.reset_column_information
      end

      if self.required_changed?
        Object.send(:remove_const, tag_class_name.to_sym)
      end
    end
  end

  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ;  20                         ; end
  def self.outline  ;  "long"                      ; end
  def self.sort_by  ;  "customfields.created_at DESC" ; end

  #----------------------------------------------------------------------------
  def name
    self.field_name
  end
end
