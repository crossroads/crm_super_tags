ApplicationHelper.module_eval do

  #----------------------------------------------------------------------------
  def link_to_inline(id, url, options = {})
    text = options[:text] || id.to_s.titleize
    text = (arrow_for(id) + text) unless options[:plain]
    related = (options[:related] ? ", related: '#{options[:related]}'" : "")

    # Close any open 'edit' forms before loading the create form.
    before_hook = id.to_s.start_with?("create_") ? "if(crm.close_all_forms) crm.close_all_forms();" : ""

    link_to_remote(text,
      :url    => url,
      :method => :get,
      :with   => "{ cancel: Element.visible('#{id}')#{related} }",
      :before => before_hook
    )
  end

end

