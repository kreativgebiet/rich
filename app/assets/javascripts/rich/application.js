// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs

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
	
	$('.test').live('click', function(e){
		//var url = $(this).parents('div.gal-item').data('url');
		var url = "http://www.google.nl/images/nav_logo89.png";
		
		// TODO: this is very ckeditor centric and should be rewritten to also handle the case
		// where files are browsed/uplaoded form a generic form
		window.opener.CKEDITOR.tools.callFunction($.QueryString["CKEditorFuncNum"], url);
		window.close();
	})
});


// $(document).ready(function(){
//   $("div.gal-item div.gal-inner-holder")
//     .live('mouseover', function(e){
//       $(this).addClass('hover');
//     })
//     .live('mouseout', function(e){
//       $(this).removeClass('hover');
//     })
//     .live('click', function(e){
//       var url = $(this).parents('div.gal-item').data('url');
//       CKEDITOR.tools.callFunction(CKEditorFuncNum, url);
//       window.close();
//     });
//   
// });
