require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe "load_missing_constant" do
  after { Object.send(:remove_const, :Tag1) }

  it { Tag1.should_not be_nil }

  it "should belong to a polymorphic customizable" do
    column_names = Tag1.columns.map(&:name)
    column_names.should include('customizable_id')
    column_names.should include('customizable_type')
  end
end
