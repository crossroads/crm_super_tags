require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/customfields/_create.html.haml" do

  before(:each) do
    login_and_assign(:admin => true)

    assign(:customfield, Customfield.new)
  end

  it "should render [create customfield] form" do
    render

    view.should render_template(:partial => "admin/customfields/_top_section")

    rendered.should have_tag("form[class=new_customfield]")
  end
end
