# Install hook code here

puts "== Copying assets to public/"
`cp -r vendor/plugins/crm_tags/public/* public/`
`cp -r vendor/plugins/crm_super_tags/public/* public/`

puts <<-EOF
The Super Tags plugin for Fat Free CRM is designed to let you store custom information on your models.
Configure your custom fields through the super tags admin interface,
then tag your models and enjoy your new custom fields.

This plugin requires the 'crm_tags' plugin, and some gem dependencies.
Add these lines to the bottom of your Gemfile:

    gem 'acts-as-taggable-on', '>= 2.0.6'
    gem 'acts_as_list'

Then run `bundle install`.


Now install the 'crm_tags' plugin by running:

  rails plugin install git://github.com/crossroads/crm_tags.git


Once the plugins are installed, run the following command:

  rake db:migrate:plugins

EOF

