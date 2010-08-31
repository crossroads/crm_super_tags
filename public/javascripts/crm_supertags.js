crm.set_tag_list_event = function(controller, asset, asset_id) {
  // Adds the 'on_change' hook for the FacebookList, to AJAX load supertag form fields.
  var supertag_list_options = $H({
      onChange: function(){
        crm.load_supertag_fields(controller, $('tag_list').value, asset_id);
      }
  });
  fbtaglist.options.update(supertag_list_options);
};

crm.load_supertag_fields = function(controller, tags, asset_id) {
  // AJAX loads the form fields for each super_tag
  new Ajax.Request('/' + controller + '/super_tags', {
    asynchronous  : true,
    evalScripts:true,
    method:'get',
    parameters: { tags      : tags,
                  asset_id  : asset_id,
                  collapsed : "no" }
  });
};

