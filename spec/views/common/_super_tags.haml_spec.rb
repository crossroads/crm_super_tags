require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "common/_super_tags.html.haml" do
  before(:each) do
    login_and_assign(:admin => true)

    @customfield = Factory(:customfield, :field_name => 'test', :field_type => 'VARCHAR(255)')
    @tag = @customfield.tag
    assigns[:opportunity] = @opportunity = Factory(:opportunity, :tag_list => @tag.name)
  end

  it "should render [edit super tag] form" do
    fields_for @opportunity do |f|
      render :partial => 'common/super_tags', :locals => {:f => f}
    end

    puts response.body
    response.should have_tag("input[id=opportunity_tag1_attributes_test]")
  end
end
