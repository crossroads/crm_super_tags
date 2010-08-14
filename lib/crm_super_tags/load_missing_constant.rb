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
    if const_name.to_s.match(/\ATag(\d+)\Z/)
      table_name = "tag#{$1}s"
      eval %Q{
        class #{const_name} < ActiveRecord::Base
          unless connection.table_exists?('#{table_name}')
            connection.create_table('#{table_name}') do |t|
              t.references :customizable, :polymorphic => true
            end
          end
        end
      }
      const_name.to_s.constantize
    else
      load_missing_constant_without_tags(from_mod, const_name)
    end
  end

  alias_method_chain :load_missing_constant, :tags
end
