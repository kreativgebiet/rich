// Rich filebrowser configuration, initialization and main controller

var rich = rich || {};

rich.Browser = function(){
	
	this._options = {
		currentStyle: '',
		insertionModeMany: false,
		currentPage: 1,
		loading: false,
		reachedBottom: false,
		viewModeGrid: true
	};
	
};

rich.Browser.prototype = {
	
	initialize: function() {
		// intialize styles
		this.initStyles($.QueryString["allowed_styles"], $.QueryString["default_style"]);
		
		// initialize image insertion mode
		this._options.insertionModeMany = ($.QueryString["insert_many"]=="true")?true:false;
		this.toggleInsertionMode(false);
    	this.toggleViewMode(false);
	},
	
	initStyles: function(opt, def) {
		opt=opt.split(',');
		$.each(opt, function(index, value) { 
			if(value != 'rich_thumb') $('#styles').append("<li class='scope' id='style-"+value+"' data-rich-style='"+value+"'>"+value+"</li>");
		});
		
		browser.selectStyle(def);
		
		if(opt.length < 2) {
			$('#styles').hide();
			browser.selectStyle(opt[0]);
		}
	},
	
	setLoading: function(loading) {
		this._options.loading = loading;
		
		if(loading == true) {
			// $('#loading').css({visibility: 'visible'});
			$('#loading').fadeIn();
		} else {
			$('#loading').fadeOut();
		}
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

    toggleViewMode: function(switchMode) {
      if(switchMode==true) {
        this._options.viewModeGrid = !this._options.viewModeGrid;
      } else {
        this._options.viewModeGrid = ($.QueryString["viewMode"]=="grid") ? false : true;
      }

      if(this._options.viewModeGrid == true) {
        $('#view-grid').hide();
        $('#view-list').show();
        $('#items').addClass('list');
      } else {
        $('#view-grid').show();
        $('#view-list').hide();
        $('#items').removeClass('list');
      }
    },
	
	selectItem: function(item) {
		var url = $(item).data('uris')[this._options.currentStyle];
		var id = $(item).data('rich-asset-id');
		var type = $(item).data('rich-asset-type');
		var name = $(item).data('rich-asset-name');
		
		
		if($.QueryString["CKEditor"]=='picker') {
			window.opener.assetPicker.setAsset($.QueryString["dom_id"], url)
		} else {
			window.opener.CKEDITOR.tools.callFunction($.QueryString["CKEditorFuncNum"], url, id, name);			
		}
		
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
	browser.initialize();
	
	new rich.Uploader();

	// hook up insert mode switching
	$('#insert-one, #insert-many').click(function(e){
		browser.toggleInsertionMode(true);
    e.preventDefault();
    return false;
  });

  // hook up insert view switching
  $('#view-grid, #view-list').click(function(e){
    browser.toggleViewMode(true);
    e.preventDefault();
    return false;
  });

	// hook up style selection
	$('#styles li').click(function(e){
		browser.selectStyle($(this).data('rich-style'));
	});

	// hook up item insertion
	$('#items li img').live('click', function(e){
		browser.selectItem(e.target);
	});
	
	// fluid pagination
	$(window).scroll(function(){
		browser.loadNextPage();
	});
	
});