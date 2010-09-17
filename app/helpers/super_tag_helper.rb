module SuperTagHelper
  def customfield_tag(f, super_tag, field, params = {})
    params = { :style => "width: #{field.display_width}px;" }.merge(params)

    case field.form_field_type
    when 'short_answer', 'number'
      f.text_field field.field_name, params
    when 'long_answer'
      f.text_area field.field_name, params.merge(:style => params[:style] += " height: #{(field.display_width * 1/2).to_i}px;")
    when 'checkbox'
      f.check_box field.field_name
    when 'date'
      page = f.text_field(field.field_name, params.merge(:id => field.field_name))
      page << javascript_tag("crm.date_select_popup('#{field.field_name}', false, false);")
      page
    when 'datetime'
      page = f.text_field(field.field_name, params.merge(:id => field.field_name))
      page << javascript_tag("crm.date_select_popup('#{field.field_name}', false, true);")
      page
    end
  end
end

