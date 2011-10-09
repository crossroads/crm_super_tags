CRM Super Tags plugin for Fat Free CRM
======================================

This Fat Free CRM plugin depends on http://github.com/michaeldv/crm_tags and builds on the work started with http://github.com/bkd/crm_customfields
An admin interface lets you add custom fields to a tag. You can then tag any model and the custom fields for that tag will be available to you.

Installation
============

1) This plugin requires the 'crm_tags' plugin. Install this and it's dependencies first by running:

    rails plugin install git://github.com/mbleigh/acts-as-taggable-on.git
    rails generate acts_as_taggable_on_migration
    rake db:migrate
    rails plugin install git://github.com/crossroads/crm_tags.git

2) Install the super tags plugin:

    rails plugin install git://github.com/crossroads/crm_super_tags.git

3) Run the plugin migrations:

    rake db:migrate:plugins

4) Restart your web server.

