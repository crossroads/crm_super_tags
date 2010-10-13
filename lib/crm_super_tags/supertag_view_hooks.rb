class SupertagViewHooks < FatFreeCRM::Callback::Base

  [ :account, :campaign, :contact, :lead, :opportunity ].each do |model|
    # Called from app/views/%{model}/_top_section.html.haml
    #------------------------------------------------------
    insert_after :"#{model}_top_section" do |view, context|
      view.render :partial => "/common/super_tags", :locals => {:f => context[:f]}
    end
  end

  #----------------------------------------------------------------------------
  def javascript_includes(view, context = {})
    # Load the crm_supertags.js extensions
    includes =  view.javascript_include_tag 'crm_supertags.js'
    includes << view.javascript_include_tag('tooltips.js')
    includes << view.stylesheet_link_tag('tooltips.css')
  end

  #----------------------------------------------------------------------------
  def javascript_epilogue(view, context = {})
    %Q%
    // Assign available supertag names to an array
    var super_tags = #{ActsAsTaggableOn::Tag.super_tags.map{|t| t.name }.to_json};
    %
  end

end

