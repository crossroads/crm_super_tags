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

ActsAsTaggableOn::Tag.class_eval do
  has_many :customfields

  #~ sortable :by => [ "name ASC", "created_at DESC", "updated_at DESC" ], :default => "name ASC"

  SORT_BY = {
    "name"          => "tags.name ASC",
    "date created"  => "tags.created_at DESC",
    "date updated"  => "tags.updated_at DESC"
  }

  # Default values provided through class methods.
  #----------------------------------------------------------------------------
  def self.per_page ; 20              ; end
  def self.outline  ; "long"          ; end
  def self.sort_by  ; "tags.name ASC" ; end
end
