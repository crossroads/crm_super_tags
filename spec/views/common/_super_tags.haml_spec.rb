require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "common/_super_tags.html.haml" do
  before(:each) do
    login_and_assign(:admin => true)

    @customfield = Factory(:customfield,
                           :field_label => 'Test',
                           :form_field_type => 'short_answer',
                           :tag => Factory(:tag,
                                           :name => "New Tag",
                                           :id => 10))
    @tag = @customfield.tag
    assign(:opportunity, @opportunity = Factory(:opportunity, :account => Factory(:account), :tag_list => @tag.name))
  end

#  it "should render [edit super tag] form" do
#    view.fields_for @opportunity do |f|
#      render :locals => {:f => f}
#    end
#  
#    view.should render_template(:partial => "/common/_super_tag_section")
#    rendered.should have_tag("input[id=opportunity_tag10_attributes_test]")     
#  end
end
