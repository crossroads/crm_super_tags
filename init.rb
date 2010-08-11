require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_super_tags, initializer) do
          name "Fat Free Super tags"
        author "Ben Tillman"
       version "0.1"
   description "Basic admin module for super tags"
  dependencies :"acts-as-taggable-on", :haml, :simple_column_search, :crm_tags
           tab :admin, :text => "Super tags", :url => { :controller => "admin/super_tags" }
end

require "super_tag"
