require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_super_tags, initializer) do
          name "Fat Free Super Tags"
        author "Ben Tillman"
       version "0.1"
   description "Admin module and view hooks for super tags"
  dependencies :"acts-as-taggable-on", :haml, :simple_column_search
           tab :admin, :text => "Super Tags", :url => { :controller => "admin/super_tags" }
end

require "crm_super_tags"

