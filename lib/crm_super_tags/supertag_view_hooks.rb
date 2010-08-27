class SupertagViewHooks < FatFreeCRM::Callback::Base

  [ :account, :campaign, :contact, :lead, :opportunity ].each do |model|
    # Called from app/views/%{model}/_top_section.html.haml
    #------------------------------------------------------
    define_method :"#{model}_top_section_after" do |view, context|
      view.render :partial => "/common/super_tags", :locals => {:f => context[:f]}
    end
  end

  def javascript_epilogue(view, context = {})
    # Load the crm_supertags.js file in the same directory.
    File.open(File.join(File.dirname(__FILE__), 'crm_supertags.js'), 'r').read
  end

end

