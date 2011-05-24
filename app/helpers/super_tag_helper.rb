module SuperTagHelper
  def customfield_tag(f, super_tag, field, params = {})
    params = { :style => "width: #{field.display_width}px;" }.merge(params)

    case field.form_field_type
    when 'short_answer', 'number'
      f.text_field field.field_name, params
    when 'long_answer'
      f.text_area field.field_name, params.merge(:style => params[:style] += " height: #{(field.display_width * 1/2).to_i}px;")
    when 'select_list'
      f.select field.field_name, field.select_options.split('|').map(&:strip), params
    when 'multi_select'
      page = f.select field.field_name, field.select_options.split('|').map(&:strip), params, :multiple => true
      page << hidden_field_tag("#{f.object.customizable.class.name.downcase}[#{f.object.class.name.downcase}_attributes][#{field.field_name}][]", '')
      page
    when 'checkbox'
      f.check_box field.field_name
    when 'date'
      date = f.object.send(field.field_name)
      date = date.strftime("%d/%m/%Y") if date
      page = f.text_field(field.field_name, params.update({:value => date}))
      # Grabs the element id from the created field, and initializes date select popup.
      element_id = page[/id="([a-z0-9_]*)"/, 1]
      page << javascript_tag("crm.date_select_popup('#{element_id}', false, false);")
      page
    when 'datetime'
      page = f.text_field(field.field_name, params)
      element_id = page[/id="([a-z0-9_]*)"/, 1]
      page << javascript_tag("crm.date_select_popup('#{element_id}', false, true);")
      page
    end
  end
end

