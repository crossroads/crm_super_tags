require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/customfields/create.js.rjs" do

  before(:each) do
    view.extend Admin::ApplicationHelper

    login_and_assign(:admin => true)
  end

  describe "create success" do
    before(:each) do
      assign(:customfield, @customfield = Factory(:customfield))
      assign(:customfields, [ @customfield ].paginate)
    end

    it "should hide [Create Customfield] form and insert customfield partial" do
      render

      rendered.should have_rjs(:insert, :top) do |rjs|
        with_tag("li[id=customfield_#{@customfield.id}]")
      end
      rendered.should include(%Q/$("customfield_#{@customfield.id}").visualEffect("highlight"/)
    end
  end

  describe "create failure" do
    it "create (failure): should re-render [create.html.haml] template in :create_customfield div" do
      assign(:customfield, Factory.build(:customfield, :field_name => nil)) # make it invalid
      @current_user = Factory(:user)
      assign(:users, [ @current_user ])

      render

      rendered.should have_rjs("create_customfield") do |rjs|
        with_tag("form[class=new_customfield]")
      end
      rendered.should include('visualEffect("shake"')
    end
  end
end
