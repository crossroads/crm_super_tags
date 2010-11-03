Customfield.class_eval do

  def self.form_field_types
    @@form_field_types ||= YAML.load(%Q{
      ---
      short_answer:
        :name: Short Answer
        :attributes:
          :field_type: VARCHAR(255)
          :display_width: 200
      long_answer:
        :name: Long Answer
        :attributes:
          :field_type: TEXT
          :display_width: 250
      select_list:
        :name: Dropdown List
        :attributes:
          :field_type: VARCHAR(255)
          :display_width: 200
      checkbox:
        :name: Checkbox
        :attributes:
          :field_type: BOOLEAN
      date:
        :name: Date
        :attributes:
          :field_type: DATE
          :display_width: 100
      datetime:
        :name: "Date & Time"
        :attributes:
          :field_type: TIMESTAMP
          :display_width: 150
      number:
        :name: Number
        :attributes:
          :field_type: DECIMAL
          :display_width: 60
    })
  end

end
