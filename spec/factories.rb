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
# along with this program.  If not, see <http:#www.gnu.org/licenses/>.
#------------------------------------------------------------------------------

require 'ffaker'

#----------------------------------------------------------------------------
Factory.define :tag, :class => ActsAsTaggableOn::Tag do |t|
  t.name                { Faker::Name.first_name }
end

#----------------------------------------------------------------------------
Factory.define :customfield do |c|
  c.user                { |a| a.association(:user) }
  c.tag                 { |a| a.association(:tag) }
  c.field_name          "foo"
  c.field_label         "foo"
  c.field_type          { Customfield::FIELD_TYPES.rand }
  c.display_width       { rand(100) + 100 }
  c.max_size            { rand(64) }
  c.required            false
  c.disabled            false
  c.updated_at          { Factory.next(:time) }
  c.created_at          { Factory.next(:time) }
end
