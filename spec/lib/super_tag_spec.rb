require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SuperTag do
  before(:each) do
    # Tests pass perfectly without dropping the tables between each step...
    # SuperTag::Clean.drop_tables
  end

  it "should define tag1" do
    Opportunity.new.tag1.should be_nil
  end

  it "should define build_tag1" do
    Opportunity.new.build_tag1.should_not be_nil
  end

  it "should accept nested attributes for tag1" do
    Factory(:customfield, :field_name => 'one',
                          :field_label => 'one',
                          :field_type => 'VARCHAR(255)')

    o = Factory(:opportunity, :account => Factory(:account))
    o.attributes = {:tag1_attributes => {'one' => 'Test'}}
    o.save
    o.reload
    o.tag1.one.should == 'Test'
  end
end
