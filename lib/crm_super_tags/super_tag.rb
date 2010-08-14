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
    #~ base.send :include, SuperTag::InstanceMethods

    base.connection.tables.each do |table_name|
      if table_name.match(/\A(tag\d+)s\Z/)
        base.class_eval %Q{
          has_one :#{$1}, :as => :customizable
          accepts_nested_attributes_for :#{$1}
        }
      end
    end
  end

  #~ module InstanceMethods
    #~ def method_missing(method, *args)
      #~ begin
        #~ super
      #~ rescue
        #~ if method.to_s.match(/\A(build_)?(tag(\d+))\Z/)
          #~ self.class.class_eval %Q{
            #~ has_one :#{$2}, :as => :customizable
            #~ accepts_nested_attributes_for :#{$2}
          #~ }
          #~ send(method)
        #~ else
          #~ raise
        #~ end
      #~ end
    #~ end
  #~ end
end
