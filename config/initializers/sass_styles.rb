# Overwrite some sass templates
Sass::Plugin.options[:template_location].reverse!
Sass::Plugin.add_template_location(File.join(File.dirname(__FILE__),
                                   '..','..',"app/stylesheets"))
Sass::Plugin.options[:template_location].reverse!

