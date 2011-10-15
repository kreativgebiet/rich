// Wire up Rich
//= require rich/ckeditor_path
//= require ckeditor/ckeditor
//= require ckeditor/adapters/jquery

function addQueryString( url, params ) {
	var queryString = [];
	if (!params) return url;
	else {
		for (var i in params) queryString.push(i + "=" + encodeURIComponent( params[i]));
	}
	return url + ( ( url.indexOf( "?" ) != -1 ) ? "&" : "?" ) + queryString.join( "&" );
}
	
// implement a basic plugin to insert rich images

// accepted properties:
// richImageUrl - path to image browser action
// richImageAllowedStyles - list of allowed image styles, defaults to all
// richImageOwnerType
// richImageOwnerId

CKEDITOR.plugins.add('richimage',
{
    init: function(editor) {
	
		// register a callback that actually inserts a selected image
        editor._.insertImagefn = CKEDITOR.tools.addFunction(function(url, id){
			this.insertHtml('<img src="' + url + '" alt="" data-rich-image-id="' + id + '" />');
		}, editor );
		
		// clean up the callback
		editor.on( 'destroy', function () { CKEDITOR.tools.removeFunction( this._.insertImagefn ); } );

		editor.addCommand( 'insertRichImage', {
			exec: function(editor) {
				var params = {};
				params.CKEditor = editor.name;
				params.CKEditorFuncNum = editor._.insertImagefn;
				var url = addQueryString(editor.config.richImageUrl, params );
				editor.popup(url, 860, 400);
			}
		});
		
		editor.ui.addButton( 'richImage', {
			label : editor.lang.common.image,
			command: 'insertRichImage',
			icon: '/assets/rich/images.png'
		});
    }
});