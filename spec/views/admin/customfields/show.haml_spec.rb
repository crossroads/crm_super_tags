require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/customfields/show.html.haml" do

  before(:each) do
  login_and_assign(:admin => true)
    assign(:customfield, Factory(:customfield, :id => 42))
    assign(:users, [ @current_user ])
  end

  it "should render customfield landing page" do
    render

    rendered.should have_tag("div[id=edit_customfield]")
  end
end
