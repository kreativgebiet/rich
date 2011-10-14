// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require rich/uploader

(function($) {
  $.QueryString = (function(a) {
    if (a == "") return {};
    var b = {};
    for (var i = 0; i < a.length; ++i)
    {
      var p=a[i].split('=');
      if (p.length != 2) continue;
      b[p[0]] = decodeURIComponent(p[1].replace(/\+/g, " "));
    }
    return b;
  })(window.location.search.substr(1).split('&'))
})(jQuery);

$(function() {
	
	// click an image to insert it in the editor
	$('#images li img').live('click', function(e){
		//var url = $(this).data('url');
		var url = $(this).attr('src');
		var id = $(this).data('rich-image-id');
		
		
		window.opener.CKEDITOR.tools.callFunction($.QueryString["CKEditorFuncNum"], url, id);
		window.close();
	})
	
	// fancy uploading
	new rich.Uploader();
	
});

