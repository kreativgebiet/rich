/**
 * The abbr dialog definition.
 *
 * Created out of the CKEditor Plugin SDK:
 * http://docs.ckeditor.com/#!/guide/plugin_sdk_sample_1
 */

// Our dialog definition.
CKEDITOR.dialog.add( 'image_propDialog', function( editor ) {
	return {

		// Basic properties of the dialog window: title, minimum size.
		title: 'Image Properties',
		minWidth: 400,
		minHeight: 100,

		// Dialog window contents definition.
		contents: [
			{
				// Definition of the Basic Settings dialog tab (page).
				id: 'tab-basic',
				label: 'Properties',

				// The tab contents.
				elements: [
					{
						// Text input field for the abbreviation text.
						type: 'text',
						id: 'caption',
						label: 'Caption',
		        setup: function( element ) {
            	this.setValue( element.getAttribute( "data-caption" ) );
		        },
           commit: function( element ) {
			        var caption = this.getValue();
	            if ( caption && caption !== '' && element.getName() == 'img') {
	              element.setAttribute( 'data-caption', caption );
	            }
	            else{
	              element.removeAttribute( 'data-caption' );
	            }
		        }
					}
				]
			},

		],

	   onShow: function() {
        var selection = editor.getSelection(),
            element = selection.getStartElement();

        this.element = element;
        this.setupContent( this.element );
    },

		// This method is invoked once a user clicks the OK button, confirming the dialog.
		onOk: function() {

			// The context of this function is the dialog object itself.
			// http://docs.ckeditor.com/#!/api/CKEDITOR.dialog
        var dialog = this,
        	image = this.element;

        this.commitContent( image );

			// // Creates a new <abbr> element.
			// var caption = editor.document.createElement( 'abbr' );

			// // Set element attribute and text, by getting the defined field values.
			// abbr.setAttribute( 'title', dialog.getValueOf( 'tab-basic', 'title' ) );
			// abbr.setText( dialog.getValueOf( 'tab-basic', 'abbr' ) );

			// // Now get yet another field value, from the advanced tab.
			// var id = dialog.getValueOf( 'tab-adv', 'id' );
			// if ( id )
			// 	abbr.setAttribute( 'id', id );

			// // Finally, inserts the element at the editor caret position.
			// editor.insertElement( abbr );
		}
	};
});