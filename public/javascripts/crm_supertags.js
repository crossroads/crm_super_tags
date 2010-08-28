crm.set_tag_list_event = function(controller, asset, asset_id) {
  // Sets the 'on_blur' hook for the tag_list, to AJAX load supertag form fields
  // when the input changes.
  Event.observe($(asset+'_tag_list'), 'change', function(event) {
    var element = Event.element(event);
    crm.load_supertag_fields(controller, element.value, asset_id);
  });
};

crm.load_supertag_fields = function(controller, tags, asset_id) {
  // AJAX loads the form fields for each super_tag
  new Ajax.Request('/' + controller + '/super_tags', {
    asynchronous  : true,
    evalScripts:true,
    method:'get',
    parameters: { tags     : tags,
                  asset_id : asset_id }
  });
};

