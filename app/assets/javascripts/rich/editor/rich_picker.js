// Direct asset picker

var rich = rich || {};
rich.AssetPicker = function(){
	
};

rich.AssetPicker.prototype = {
	
	showFinder: function(dom_id, options){
		// open a popup
		var params = {};
		params.CKEditor = 'picker'; // this is not CKEditor
		params.default_style = options.default_style;
		params.allowed_styles = options.allowed_styles;
		params.insert_many = options.insert_many;
		params.type = options.type || "image";
		params.viewMode = options.view_mode || "grid";
		params.scoped = options.scoped || false;
		if(params.scoped == true) {
			params.scope_type = options.scope_type
			params.scope_id = options.scope_id;
		}
		params.dom_id = dom_id;
		var url = addQueryString(options.richBrowserUrl, params );
		window.open(url, 'filebrowser', "width=860,height=500")
  },

	setAsset: function(dom_id, asset){
		$(dom_id).val(asset);
		$(dom_id).siblings('img.rich-image-preview').first().attr({src: asset});
  }

};

// Rich Asset input
var assetPicker = new rich.AssetPicker();