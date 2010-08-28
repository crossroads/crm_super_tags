require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe "admin/customfields/_create.html.haml" do

  before(:each) do
    login_and_assign(:admin => true)

    assigns[:customfield] = Customfield.new
  end

  it "should render [create customfield] form" do
    template.should_receive(:render).with(hash_including(:partial => "admin/customfields/top_section"))

    render "admin/customfields/_create.html.haml"
    response.should have_tag("form[class=new_customfield]")
  end
end

