//----------------------------------------------------------------------------
// Adds the 'on_change' hook for the FacebookList, to AJAX load supertag form fields.
crm.set_tag_list_event = function(controller, asset, asset_id) {
  var extra_supertag_options = $H({
      onAdd: function(tag, el){
        // Check that the tag is not being added more than twice (case INSENSITIVE)
        var alreadyAdded = (fbtaglist.bits.values().findAll(function(s){return s.toLowerCase() == tag.toLowerCase() }).length > 1);
        if(alreadyAdded){
          // turn off the onDispose hook for this call to .dispose()
          var onDisposeHook = fbtaglist.options.get('onDispose');
          fbtaglist.options.set('onDispose', function(el){});
          fbtaglist.dispose(el);
          fbtaglist.options.set('onDispose', onDisposeHook);
        } else {
          // load the supertag form fields if not already loaded.
          crm.load_supertag_fields(controller, tag, asset_id);
        };
      },
      onDispose: function(tag){
        // remove the supertag form fields if they were loaded.
        tag = tag.toLowerCase();
        var form_id = loadedSupertagForms.get(tag);
        if(form_id){
          $(form_id).remove();
          loadedSupertagForms.unset(tag);
        };
      }
  });
  fbtaglist.options.update(extra_supertag_options);
};

//----------------------------------------------------------------------------
// AJAX loads the form fields for each super_tag
crm.load_supertag_fields = function(controller, tags, asset_id) {
  new Ajax.Request('/' + controller + '/super_tags', {
    asynchronous  : true,
    evalScripts:true,
    method:'get',
    parameters: { tags      : tags,
                  asset_id  : asset_id,
                  collapsed : "no" }
  });
};

//----------------------------------------------------------------------------
// Fires an 'onclick' event on all '.close' buttons in the DOM.
// (closes any current edit forms)
crm.close_all_forms = function() {
  $$('.close').each(function(el){el.onclick();});
};

// Initialize the hash to store which supertag forms have been loaded.
// {'supertag' => 'div element id'}
var loadedSupertagForms = new Hash();

