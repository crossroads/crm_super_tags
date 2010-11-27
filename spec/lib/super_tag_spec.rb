require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SuperTag do
  before(:each) do
#    SuperTag::Clean.drop_tables
#    DatabaseCleaner.clean
  end

  it "should define tag1" do
    Opportunity.new.tag1.should be_nil
  end

  it "should define build_tag1" do
    Opportunity.new.build_tag1.should_not be_nil
  end

  it "should accept nested attributes for tag1" do
    c = Factory(:customfield, :field_name => 'one',
                              :field_label => 'one',
                              :field_type => 'VARCHAR(255)')

    o = Factory(:opportunity, :account => Factory(:account))
    o.attributes = {:"tag#{c.tag.id}_attributes" => {'one' => 'Test'}}
    o.save
    o.reload
    o.send("tag#{c.tag.id}").one.should == 'Test'
  end
end
