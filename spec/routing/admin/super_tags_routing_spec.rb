require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::SuperTagsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/admin/super_tags" }.should route_to(:controller => "admin/super_tags", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/admin/super_tags/new" }.should route_to(:controller => "admin/super_tags", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/super_tags/1" }.should route_to(:controller => "admin/super_tags", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/super_tags/1/edit" }.should route_to(:controller => "admin/super_tags", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/super_tags" }.should route_to(:controller => "admin/super_tags", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/super_tags/1" }.should route_to(:controller => "admin/super_tags", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/super_tags/1" }.should route_to(:controller => "admin/super_tags", :action => "destroy", :id => "1")
    end

    it "recognizes and generates #search" do
      { :get => "/admin/super_tags/search" }.should route_to( :controller => "admin/super_tags", :action => "search" )
    end

    it "recognizes and generates #auto_complete" do
      { :post => "/admin/super_tags/auto_complete" }.should route_to( :controller => "admin/super_tags", :action => "auto_complete" )
    end
  end
end
