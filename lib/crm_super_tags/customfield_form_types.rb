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
      checkbox:
        :name: Checkbox
        :attributes:
          :field_type: INTEGER
      date:
        :name: Date
        :attributes:
          :field_type: DATE
          :display_width: 100
      datetime:
        :name: "Date & Time"
        :attributes:
          :field_type: DATETIME
          :display_width: 150
      number:
        :name: Number
        :attributes: 
          :field_type: INTEGER
          :display_width: 60
    })
  end

end
