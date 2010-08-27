ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.resources :super_tags, :collection => { :search => :get, :auto_complete => :post, :options => :get, :redraw => :post }
    admin.resources :acts_as_taggable_on_tags, :controller => :super_tags
    admin.resources :customfields, :except => :index, :collection => { :search => :get, :auto_complete => :post, :options => :get, :redraw => :post }
  end

  map.connect ":controller/super_tags", :action => :super_tags

end

