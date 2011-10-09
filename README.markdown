CRM Super Tags plugin for Fat Free CRM
======================================

This Fat Free CRM plugin depends on http://github.com/michaeldv/crm_tags and builds on the work started with http://github.com/bkd/crm_customfields
An admin interface lets you add custom fields to a tag. You can then tag any model and the custom fields for that tag will be available to you.

Installation
============

1) This plugin requires the 'crm_tags' plugin, and some gem dependencies.
   Add these lines to the bottom of your Gemfile:

    gem 'acts-as-taggable-on', '>= 2.0.6'
    gem 'acts_as_list'

  Then run `bundle install`.

2) Install the 'crm_tags' plugin:

    rails plugin install git://github.com/crossroads/crm_tags.git

3) Install the 'crm_super_tags' plugin:

    rails plugin install git://github.com/crossroads/crm_super_tags.git

4) Run the plugin migrations:

    rake db:migrate:plugins

5) Restart your web server.

This plugin requires the 'crm_tags' plugin, and some gem dependencies.
Add these lines to the bottom of your Gemfile:

    gem 'acts-as-taggable-on', '>= 2.0.6'
    gem 'acts_as_list'

Then run `bundle install`.

