require "fat_free_crm"

FatFreeCRM::Plugin.register(:crm_super_tags, self) do
          name "Fat Free Super Tags"
        author "Ben Tillman"
       version "0.1"
   description "Admin module and view hooks for super tags"
  dependencies :crm_tags, :crm_plugin_test_overrides
           tab :admin, :text => "Super tags", :url => { :controller => "admin/super_tags" }
end

require "crm_super_tags"

Rails.configuration.middleware.insert_before ::Rack::Lock, ::ActionDispatch::Static, root.join('public')
