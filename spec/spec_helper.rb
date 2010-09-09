begin
  require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
rescue LoadError
  puts "You need to install rspec in your base app"
  exit
end

require File.dirname(__FILE__) + "/factories.rb"

plugin_spec_dir = File.dirname(__FILE__)
ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")

require 'database_cleaner'
DatabaseCleaner.strategy = :truncation, {:except => ['settings']}

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

