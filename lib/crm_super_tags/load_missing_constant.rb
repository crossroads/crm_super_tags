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

ActiveSupport::Dependencies.class_eval do
  def load_missing_constant_with_tags(from_mod, const_name)
    begin
      load_missing_constant_without_tags(from_mod, const_name)
    rescue
      if const_name.to_s.match(/\ATag(\d+)\Z/)

        table_name = "tag#{$1}s"
        unless ActiveRecord::Base.connection.table_exists?(table_name)
          ActiveRecord::Base.connection.create_table(table_name) do |t|
            t.references :customizable, :polymorphic => true
          end
        end

        klass = Class.new ActiveRecord::Base do
          belongs_to :customizable, :polymorphic => true
          validates_presence_of :customizable
        end

        Object.const_set(const_name, klass)
      else
        raise
      end
    end
  end

  alias_method_chain :load_missing_constant, :tags
end
