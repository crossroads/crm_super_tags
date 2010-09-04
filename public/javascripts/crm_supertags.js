crm.set_tag_list_event = function(controller, asset, asset_id) {
  // Adds the 'on_change' hook for the FacebookList, to AJAX load supertag form fields.
  var extra_supertag_options = $H({
      onAdd: function(tag){
        // load the supertag form fields if not already loaded.
        if(!loadedSupertagForms.get(tag)){
          crm.load_supertag_fields(controller, tag, asset_id);
        };
      },
      onDispose: function(tag){
        // remove the supertag form fields if they were loaded.
        var form_id = loadedSupertagForms.get(tag);
        if(form_id){
          $(form_id).remove();
          loadedSupertagForms.unset(tag);
        };
      }
  });
  fbtaglist.options.update(extra_supertag_options);
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

// {'supertag' => 'div element id'}
var loadedSupertagForms = new Hash();

