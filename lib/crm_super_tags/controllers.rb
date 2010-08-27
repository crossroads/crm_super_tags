[ AccountsController, CampaignsController, ContactsController,
  LeadsController, OpportunitiesController ].each do |klass|
  klass.class_eval do
    def super_tags
      if params[:tags]
        tags = params[:tags].split(",")
        @super_tags = tags.map {|t| ActsAsTaggableOn::Tag.find_by_name(t.strip) }.compact.uniq
        unless @super_tags.empty?
          model_klass = self.class.name[/(.*)Controller/, 1].singularize.constantize
          @asset = model_klass.find_by_id(params[:asset_id]) || model_klass.new
          render :template => "common/super_tags.js" and return
        end
      end
      # Else, render nothing if no supertags were found.
      render :text => ""
    end
  end
end

