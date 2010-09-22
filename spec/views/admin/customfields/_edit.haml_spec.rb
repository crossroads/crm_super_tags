require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/customfields/_edit.html.haml" do

  before(:each) do
    login_and_assign(:admin => true)

    assign(:customfield, @customfield = Factory(:customfield))
  end

  it "should render [edit customfield] form" do
    render

    view.should render_template(:partial => "admin/customfields/_top_section")

    rendered.should have_tag("form[class=edit_customfield]") do
      with_tag "input[type=hidden][id=customfield_user_id][value=#{@customfield.user_id}]"
    end
  end
end
