// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require fileuploader
//= require rich/uploader

var rich_current_style = "";
function selectStyle(name) {
	rich_current_style = name;
	$('#styles li').removeClass('selected');
	$('#style-'+name).addClass('selected');
}


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
//		var url = $(this).attr('src');
		var url = $(this).data('uris')[rich_current_style];
		var id = $(this).data('rich-image-id');
		
		window.opener.CKEDITOR.tools.callFunction($.QueryString["CKEditorFuncNum"], url, id);
		window.setTimeout(function(){
			window.close();
		},500);
	});
	
	$('#styles li').click(function(e){
		selectStyle($(this).data('rich-style'));
	});
	
	// preselect the default style
	selectStyle($('#styles').data('default-style'));
	
	// fancy uploading
	new rich.Uploader();
	
});


