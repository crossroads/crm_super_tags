# Install hook code here

puts <<-EOF
The Super Tags plugin for Fat Free CRM is designed to let you store custom information on your models.
Configure your custom fields through the super tags admin interface, then tag your models and enjoy your new custom fields.

This plugin requires the 'CRM Tags' plugin. If you haven't already, please run:

  rails plugin install git://github.com/crossroads/crm_tags.git


Once the plugin is installed run the following command:

  rake db:migrate:plugins

EOF

