// Wire up Rich
//= require ckeditor/ckeditor
//= require ckeditor/adapters/jquery

// clean up dialogs
CKEDITOR.on('dialogDefinition', function(ev) {
		var dialogName = ev.data.name;
		var dialogDefinition = ev.data.definition;
 
		if (dialogName == 'image') {
			dialogDefinition.removeContents('Upload');
			
			var tab = dialogDefinition.getContents( 'info' );
			tab.remove('txtAlt');
			tab.remove('basic');
		}
		
		if (dialogName == 'link') {
			dialogDefinition.removeContents('upload');
		}
	});