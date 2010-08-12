require 'rubygems'
require 'spork'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  #~ begin
    require File.dirname(__FILE__) + '/../../../../spec/spec_helper'
  #~ rescue LoadError
    #~ puts "You need to install rspec in your base app"
    #~ exit
  #~ end

  require File.dirname(__FILE__) + "/factories.rb"

  plugin_spec_dir = File.dirname(__FILE__)
  ActiveRecord::Base.logger = Logger.new(plugin_spec_dir + "/debug.log")
end

Spork.each_run do
  # This code will be run each time you run your specs.

end
