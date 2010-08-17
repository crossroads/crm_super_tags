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

module SuperTag
  def self.included(base)
    base.send :include, SuperTag::InstanceMethods
  end

  module InstanceMethods
    # Used by nested_attributes_association? and assign_attributes
    def respond_to?(method, include_private = false)
      super || method.to_s.match(/\Atag\d+_attributes=\Z/).present?
    end

    def method_missing(method, *args)
      begin
        super
      rescue
        if method.to_s.match(/\A(?:build_)?(tag\d+)(?:=)?\Z/)
          self.class.has_one($1, :as => :customizable)
          send(method, *args)

        elsif method.to_s.match(/\A(?:validate_associated_records_for_)?(tag\d+)(?:_attributes=)?\Z/)
          self.class.has_one($1, :as => :customizable) unless respond_to?($1)
          self.class.accepts_nested_attributes_for($1)
          send(method, *args)

        else
          raise
        end
      end
    end
  end

  module Clean
    def self.drop_tables
      ActiveRecord::Base.connection.tables.each do |table_name|
        if table_name.match(/\Atag(\d+)s\Z/)
          class_name = :"Tag#{$1}"
          Object.send(:remove_const, class_name) if Object.send(:const_defined?, class_name)
          ActiveRecord::Base.connection.drop_table(table_name)
        end
      end
    end
  end
end
