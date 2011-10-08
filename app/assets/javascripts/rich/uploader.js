// Implementation of the QQ FileUploader class for use in Rich

var rich = rich || {};

rich.Uploader = function(){
	
	this._options = {
		uploadButtonId: 'upload',
		insertionPoint: 'uploadBlock'
	};
	
	// create the qq uploader
	var self = this;
	var uploader = new qq.FileUploaderBasic({
	  button: document.getElementById(self._options.uploadButtonId),
		multiple: true,
		maxConnections: 1,
		action: $("#new_rich_rich_image").attr("action"),
		params: { authenticity_token: $("input[name='authenticity_token']").attr("value") },
		debug: true,
		onComplete: function(id, fileName, responseJSON) { self.uploadComplete(id, fileName.responseJSON); },
		onSubmit: function(id, fileName) { self.uploadSubmit(id, fileName); },
		onProgress: function(id, fileName, loaded, total) { self.uploadProgress(id, fileName, Math.round(loaded/total*100)); }
	});
};

rich.Uploader.prototype = {

	uploadComplete: function(id, fileName, responseJSON){
		$('#im'+id+' span').text("Done!");
  },

	uploadSubmit: function(id, fileName) {
		// insert a new image placeholder after the upload button
		$('#'+this._options.insertionPoint).after('<li id="im'+id+'"><span>Starting</span></li>');
	},
	
	uploadProgress: function(id, fileName, progress) {
		$('#im'+id+' span').text(progress+"%");
	},

};