CRM Super Tags
============

This Fat Free CRM plugin depends on http://github.com/michaeldv/crm_tags and builds on the work started with http://github.com/bkd/crm_customfields
An admin interface lets you add custom fields to a tag. You can then tag any model and the custom fields for that tag will be available to you.

Installation
============

The super tags plugin can be installed by running:

    rails install plugin git://github.com/crossroads/crm_super_tags.git

Then run the plugin migrations:

    rake db:migrate:plugins

Finally, restart your web server.

