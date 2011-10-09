CRM Super Tags plugin for Fat Free CRM
======================================

This Fat Free CRM plugin depends on http://github.com/michaeldv/crm_tags and builds on the work started with http://github.com/bkd/crm_customfields
An admin interface lets you add custom fields to a tag. You can then tag any model and the custom fields for that tag will be available to you.

Installation
============

1) This plugin requires the 'CRM Tags' plugin. Install this first by running:

    rails plugin install git://github.com/crossroads/crm_tags.git

   Note: You don't need to run the migrations until after you have installed the super tags plugin.

2) Install the super tags plugin:

    rails plugin install git://github.com/crossroads/crm_super_tags.git

3) Run the plugin migrations:

    rake db:migrate:plugins

4) Restart your web server.

