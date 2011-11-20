// Rich filebrowser configuration, initialization and main controller

var rich = rich || {};

rich.Browser = function(){
	
	this._options = {
		currentStyle: '',
		insertionModeMany: false,
		currentPage: 1,
		loading: false,
		reachedBottom: false
	};
	
};

rich.Browser.prototype = {
	
	initialize: function() {
		this.toggleInsertionMode(false);
	},
	
	setLoading: function(loading) {
		this._options.loading = loading;
	},
	
	selectStyle: function(name) {
		this._options.currentStyle = name;
		$('#styles li').removeClass('selected');
		$('#style-'+name).addClass('selected');	
  },

	toggleInsertionMode: function(switchMode) {
		if(switchMode==true) this._options.insertionModeMany = !this._options.insertionModeMany;
		
		if(this._options.insertionModeMany == true) {
	    $('#insert-one').hide();
	    $('#insert-many').show();
	  } else {
	    $('#insert-one').show();
	    $('#insert-many').hide();
	  }
	},
	
	selectItem: function(item) {
		var url = $(item).data('uris')[this._options.currentStyle];
		var id = $(item).data('rich-asset-id');
		
		// differentiate between CKEditor browsing and direct asset selection
		window.opener.CKEDITOR.tools.callFunction($.QueryString["CKEditorFuncNum"], url, id);
		
		// wait a short while before closing the window or regaining focus
		var self = this;
		window.setTimeout(function(){
			    if(self._options.insertionModeMany == false) {  			
			  window.close();
		  } else {
		    window.focus();
		  }
		},100);
	},
	
	loadNextPage: function() {
		if (this._options.loading || this._options.reachedBottom) {
      return;
    }

    if(this.nearBottomOfWindow()) {
			this.setLoading(true);
      this._options.currentPage++;

			var self = this;
      $.ajax({
        url: window.location.href + '&page=' + this._options.currentPage,
        type: 'get',
        dataType: 'script',
        success: function(e) {
					console.log(e);
					if(e=="") self._options.reachedBottom = true;
					self.setLoading(false);
        }
      });
    }
	},
	
	nearBottomOfWindow: function() {
		return $(window).scrollTop() > $(document).height() - $(window).height() - 100;
	}

};


var browser;

$(function(){
	
	browser = new rich.Browser();
	new rich.Uploader();

	// set defaults and initialize
	browser._options.insertionModeMany = defaultInsertionMode;
	browser.initialize();
	
	// hook up insert mode switching
	$('#insert-one, #insert-many').click(function(e){
		browser.toggleInsertionMode(true);
    e.preventDefault();
    return false;
  });

	// preselect the default style
	browser.selectStyle($('#styles').data('default-style'));

	// hook up style selection
	$('#styles li').click(function(e){
		browser.selectStyle($(this).data('rich-style'));
	});

	// hook up image insertion
	$('#items li img').live('click', function(e){
		browser.selectItem(e.target);
	});
	
	// fluid pagination
	$(window).scroll(function(){
		browser.loadNextPage();
	});
	
});