class SupertagViewHooks < FatFreeCRM::Callback::Base

  [ :account, :campaign, :contact, :lead, :opportunity ].each do |model|
    # Called from app/views/%{model}/_top_section.html.haml
    #------------------------------------------------------
    define_method :"#{model}_top_section_after" do |view, context|
      view.render :partial => "/common/super_tags", :locals => {:f => context[:f]}
    end
  end

  def javascript_includes(view, context = {})
    # Load the crm_supertags.js extensions
    view.javascript_include_tag 'crm_supertags.js'
  end

end

