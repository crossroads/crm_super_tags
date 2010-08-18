module ApplicationHelper
  def customfield(f, super_tag, field, params = {})
    params = { :style => "width: #{field.display_width}px;" }.merge(params)

    case field.field_type
    when 'DATE', 'DATETIME', 'INTEGER', 'VARCHAR(255)'
      f.text_field field.field_name, params
    when 'TEXT'
      f.text_area field.field_name, params.merge(:style => params[:style] += " height: #{field.display_width}px;")
    end
  end
end
