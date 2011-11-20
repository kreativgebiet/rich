// Direct asset finder configuration

var rich = rich || {};
rich.AssetFinder = function(){
	
};

rich.AssetFinder.prototype = {
	
	showFinder: function(id){
		// open a popup
		console.log(id);
  },

	setAsset: function(id, asset){
		// callback from popup
		console.log(id);
  },
	
};

// Rich Asset input
var assetFinder = new rich.AssetFinder();
$(function(){
	$('.rich_asset').live('click', function(e){

		if($(this).get(0).tagName=="INPUT") {
			assetFinder.showFinder($(this).attr('id'));
		}
	});
	
	// on hover, show a thumbnail of the selected image?
	
});