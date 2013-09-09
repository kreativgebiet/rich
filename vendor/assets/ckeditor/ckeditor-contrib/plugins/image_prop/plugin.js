/**
 * Basic sample plugin inserting abbreviation elements into CKEditor editing area.
 *
 * Created out of the CKEditor Plugin SDK:
 * http://docs.ckeditor.com/#!/guide/plugin_sdk_sample_1
 */

// Register the plugin within the editor.
CKEDITOR.plugins.add( 'image_prop', {

	// Register the icons.

	// The plugin initialization logic goes inside this method.
	init: function( editor ) {

		// Define an editor command that opens our dialog.
		editor.addCommand( 'image_prop', new CKEDITOR.dialogCommand( 'image_propDialog' ) );

		// Create a toolbar button that executes the above command.
		editor.ui.addButton( 'image_prop', {

			// The text part of the button (if available) and tooptip.
			label: 'Image Properties',

			// The command to execute on click.
			command: 'image_prop',

			// The button placement in the toolbar (toolbar group name).
			toolbar: 'insert',
			icon: '/assets/rich/image_edit.png'

		});

		// Register our dialog file. this.path is the plugin folder path.
		CKEDITOR.dialog.add( 'image_propDialog', this.path + 'dialogs/image_prop.js' );
	}
});

