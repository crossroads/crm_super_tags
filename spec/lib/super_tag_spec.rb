require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SuperTag do
  before :all do
    Tag1
    Opportunity.class_eval { include SuperTag }
  end

  after :all do
    ActiveRecord::Base.connection.tables.each do |table_name|
      if table_name.match(/\Atag(\d+)s\Z/)
        Object.send(:remove_const, :"Tag#{$1}")
        ActiveRecord::Base.connection.drop_table(table_name)
      end
    end
  end

  it "should define tag1" do
    Opportunity.new.tag1.should be_nil
  end

  it "should define build_tag1" do
    Opportunity.new.build_tag1.should_not be_nil
  end

  it "should accept nested attributes for tag1" do
    Factory(:customfield, :field_name => 'one', :field_type => 'VARCHAR(255)')
    o = Factory(:opportunity)

    o.attributes = {:tag1_attributes => {:one => 'Test'}}
    o.save
    o.reload
    o.tag1.one.should == 'Test'
  end
end
