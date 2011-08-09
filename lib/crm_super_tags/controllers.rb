[ AccountsController, CampaignsController, ContactsController,
  LeadsController, OpportunitiesController ].each do |klass|
  klass.class_eval do
    def super_tags
      if params[:tags]
        model_klass = self.class.name[/(.*)Controller/, 1].singularize.constantize
        tags = params[:tags].split(",")
        @super_tags = tags.map do |t|
          ActsAsTaggableOn::Tag.where(:name => t.strip).where('taggable_type IS NULL OR taggable_type = ?', model_klass.name).first
        end.compact.uniq
        @asset = model_klass.find_by_id(params[:asset_id]) || model_klass.new
        render :template => "common/super_tags.js" and return
      end
      # Else, render nothing if no supertags were found.
      render :text => ''
    end
  end
end

