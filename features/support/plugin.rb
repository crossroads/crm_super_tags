require File.expand_path(File.dirname(__FILE__) + '/../../spec/factories')

Before do
  ::ActiveRecord::Base.connection.execute('DROP TABLE IF EXISTS customfields_for_tag_1')
end
