require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Admin::CustomfieldsController do
  describe "routing" do

    it "recognizes and generates #new" do
      { :get => "/admin/customfields/new" }.should route_to(:controller => "admin/customfields", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/admin/customfields/1" }.should route_to(:controller => "admin/customfields", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/admin/customfields/1/edit" }.should route_to(:controller => "admin/customfields", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/admin/customfields" }.should route_to(:controller => "admin/customfields", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/admin/customfields/1" }.should route_to(:controller => "admin/customfields", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/admin/customfields/1" }.should route_to(:controller => "admin/customfields", :action => "destroy", :id => "1")
    end

    it "recognizes and generates #search" do
      { :get => "/admin/customfields/search" }.should route_to( :controller => "admin/customfields", :action => "search" )
    end

    it "recognizes and generates #auto_complete" do
      { :post => "/admin/customfields/auto_complete" }.should route_to( :controller => "admin/customfields", :action => "auto_complete" )
    end
  end
end
