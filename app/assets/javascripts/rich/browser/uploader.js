// Implementation of the QQ FileUploader class for use in Rich

var rich = rich || {};

rich.Uploader = function(){
	
	this._options = {
		uploadButtonId: 'upload',
		insertionPoint: 'uploadBlock',
		uploadType: $.QueryString["type"],
		scoped: $.QueryString["scoped"],
		scope_type: $.QueryString["scope_type"],
		scope_id: $.QueryString["scope_id"]
	};
	
	// create the qq uploader
	var self = this;
	var uploader = new qq.FileUploaderBasic({
	  button: document.getElementById(self._options.uploadButtonId),
		multiple: true,
		maxConnections: 3,
		action: $("#new_rich_file").attr("action"),
		params: { authenticity_token: $("input[name='authenticity_token']").attr("value"),
		 	      simplified_type: this._options.uploadType,
				  scoped: this._options.scoped,
				  scope_type: this._options.scope_type,
				  scope_id: this._options.scope_id
		},
		debug: true,
		onComplete: function(id, fileName, responseJSON) { self.uploadComplete(id, fileName, responseJSON); },
		onSubmit: function(id, fileName) { self.uploadSubmit(id, fileName); },
		onProgress: function(id, fileName, loaded, total) { self.uploadProgress(id, fileName, Math.round(loaded/total*100)); }
	});
};

rich.Uploader.prototype = {

	uploadComplete: function(id, fileName, response){
		if (response.success){
			$('#up'+id+' .progress-bar').first().width("100%");
			$('#up'+id+' .spinner').first().addClass("spinning");
			//get the created image object's id from the response and use it to request the thumbnail
			$.get("/rich/files/"+response.rich_id, function(data) {
				$('#up'+id).replaceWith(data).addClass("test");
				$('#image'+response.rich_id).addClass("new");
			});
    } else {
				$('#up'+id+' .spinner').first().addClass("error");
				$('#up'+id+' .spinner').first().removeClass("spinning");
                $('#up'+id+' .progress-bar').first().remove();
    }
  },

	uploadSubmit: function(id, fileName) {
		// insert a new image placeholder after the upload button
		$('#'+this._options.insertionPoint).after('<li id="up'+id+'"><div class="placeholder progress"><div class="progress-bar" style="width: 0%;"></div><div class="spinner"></div></div><p>'+fileName+'</p></li>');
	},
	
	uploadProgress: function(id, fileName, progress) {
		$('#up'+id+' .progress-bar').first().width(progress+"%");
		
		if(progress > 90) {
			// start spinning
			$('#up'+id+' .spinner').first().addClass("spinning");
		}
	},

};