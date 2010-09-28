require File.expand_path(File.dirname(__FILE__) + '/../../spec/factories')

Before do
  SuperTag::Clean.drop_tables
end

