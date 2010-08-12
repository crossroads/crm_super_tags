require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/customfields/create.js.rjs" do

  before(:each) do
    template.extend Admin::ApplicationHelper

    login_and_assign(:admin => true)
  end

  describe "create success" do
    before(:each) do
      assigns[:customfield] = @customfield = Factory(:customfield)
      assigns[:customfields] = [ @customfield ].paginate
    end

    it "should hide [Create Customfield] form and insert customfield partial" do
      render "admin/customfields/create.js.rjs"

      response.should have_rjs(:insert, :top) do |rjs|
        with_tag("li[id=customfield_#{@customfield.id}]")
      end
      response.should include_text(%Q/$("customfield_#{@customfield.id}").visualEffect("highlight"/)
    end
  end

  describe "create failure" do
    it "create (failure): should re-render [create.html.haml] template in :create_customfield div" do
      assigns[:customfield] = Factory.build(:customfield, :field_name => nil) # make it invalid
      @current_user = Factory(:user)
      assigns[:users] = [ @current_user ]

      render "admin/customfields/create.js.rjs"

      response.should have_rjs("create_customfield") do |rjs|
        with_tag("form[class=new_customfield]")
      end
      response.should include_text('visualEffect("shake"')
    end
  end
end
