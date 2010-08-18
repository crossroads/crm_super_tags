module SuperTag
  def self.included(base)
    base.send :include, SuperTag::InstanceMethods
  end

  module InstanceMethods
    # Used by nested_attributes_association? and assign_attributes
    def respond_to?(method, include_private = false)
      super || method.to_s.match(/\Atag\d+_attributes=\Z/).present?
    end

    def method_missing(method, *args)
      begin
        super
      rescue
        if method.to_s.match(/\A(?:build_)?(tag\d+)(?:=)?\Z/)
          self.class.has_one($1, :as => :customizable)
          send(method, *args)

        elsif method.to_s.match(/\A(?:validate_associated_records_for_)?(tag\d+)(?:_attributes=)?\Z/)
          self.class.has_one($1, :as => :customizable) unless respond_to?($1)
          self.class.accepts_nested_attributes_for($1)
          send(method, *args)

        else
          raise
        end
      end
    end
  end

  module Clean
    def self.drop_tables
      ActiveRecord::Base.connection.tables.each do |table_name|
        if table_name.match(/\Atag(\d+)s\Z/)
          class_name = :"Tag#{$1}"
          Object.send(:remove_const, class_name) if Object.send(:const_defined?, class_name)
          ActiveRecord::Base.connection.drop_table(table_name)
        end
      end
    end
  end
end
