/*
* Embed Media Dialog based on http://www.fluidbyte.net/embed-youtube-vimeo-etc-into-ckeditor
*
* Plugin name:      mediaembed
* Menu button name: MediaEmbed
*
* Youtube Editor Icon
* http://paulrobertlloyd.com/
*
* @author Fabian Vogelsteller [frozeman.de]
* @version 0.1
*/
( function() {
    CKEDITOR.plugins.add( 'mediaembed',
    {
        init: function( editor )
        {
           var me = this;
           CKEDITOR.dialog.add( 'MediaEmbedDialog', function ()
           {
              return {
                 title : 'Embed Media',
                 minWidth : 550,
                 minHeight : 200,
                 contents :
                       [
                          {
                             id : 'iframe',
                             expand : true,
                             elements :[{
                                id : 'embedArea',
                                type : 'textarea',
                                label : 'Paste Embed Code Here',
                                'autofocus':'autofocus',
                                setup: function(element){
                                },
                                commit: function(element){
                                }
                              }]
                          }
                       ],
                  onOk : function() {
                    for (var i=0; i<window.frames.length; i++) {
                       if(window.frames[i].name == 'iframeMediaEmbed') {
                          var content = window.frames[i].document.getElementById("embed").value;
                       }
                    }
                    console.log(this.getContentElement( 'iframe', 'embedArea' ).getValue());
                    editor.insertHtml(this.getContentElement( 'iframe', 'embedArea' ).getValue());
                 }
              };
           } );

            editor.addCommand( 'MediaEmbed', new CKEDITOR.dialogCommand( 'MediaEmbedDialog' ) );

            editor.ui.addButton( 'MediaEmbed',
            {
                label: 'Embed Media',
                command: 'MediaEmbed',
                icon: this.path + 'images/icon.png'
            } );
        }
    } );
} )();
