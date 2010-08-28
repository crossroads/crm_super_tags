ActiveSupport::Dependencies.class_eval do
  def load_missing_constant_with_tags(from_mod, const_name)
    begin
      load_missing_constant_without_tags(from_mod, const_name)
    rescue
      if const_name.to_s.match(/\ATag(\d+)\Z/)

        table_name = "tag#{$1}s"
        unless ActiveRecord::Base.connection.table_exists?(table_name)
          ActiveRecord::Base.connection.create_table(table_name) do |t|
            t.references :customizable, :polymorphic => true
          end
        end

        klass = Class.new ActiveRecord::Base do
          belongs_to :customizable, :polymorphic => true
          validates_presence_of :customizable_type

          Customfield.all(:conditions => {:tag_id => $1, :required => true}).each do |custom|
            validates_presence_of custom.field_name
          end
        end

        Object.const_set(const_name, klass)
      else
        raise
      end
    end
  end

  alias_method_chain :load_missing_constant, :tags
end

