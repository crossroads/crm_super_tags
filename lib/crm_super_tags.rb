require "crm_super_tags/load_missing_constant"  # Build Tag%{id} classes
require "crm_super_tags/super_tag"              # Super tag mixin
require "crm_super_tags/models"                 # include Super tags
require "crm_super_tags/controllers"            # include Controller extensions
require "crm_super_tags/tag"                    # Extend tag model to have customfields
require "crm_super_tags/supertag_view_hooks"    # Define view hooks that provide super tag support

