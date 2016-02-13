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

    //check if we are inserting an object
    var dom_id_param = $.QueryString["dom_id"];
    var split_field_name = dom_id_param ? dom_id_param.split('_') : null;

		if(opt.length < 2 || (split_field_name && split_field_name[split_field_name.length - 1] == "id")) {
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
			window.opener.assetPicker.setAsset($.QueryString["dom_id"], url, id, type);
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

  performSearch: function(query) {
    this.showLoadingIconAndRefreshList();
    this._options.searchQuery = query;

    var self = this;
    $.ajax({
      url: window.location.href + '&search=' + query,
      type: 'get',
      dataType: 'script',
      success: function(e) {
        self.setLoading(false);
      }
    });
  },

  urlWithParams: function() {
    var url = window.location.href;
    if (this._options.searchQuery) url += '&search=' + this._options.searchQuery;
    return url;
  },

  showLoadingIconAndRefreshList: function() {
    this.setLoading(true);
    this._options.currentPage = 1;
    this._options.reachedBottom = false;
    $('#items li:not(#uploadBlock)').remove();
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
        url: this.urlWithParams() + '&page=' + this._options.currentPage,
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
	},

  showNameEditInput: function(p_tag) {
    var self = this;
    p_tag.hide();
    p_tag.siblings('a.delete').hide();
    p_tag.after('<form><input type="text" placeholder="' + p_tag.data('input-placeholder') + '" /></form>');
    var form = p_tag.siblings('form');
    var hideInput = function() {
      p_tag.siblings('a.delete').show();
      p_tag.show();
      form.remove();
    }
    form.find('input').focus().blur(hideInput).keydown(function(e) {
      if (e.keyCode == 27) hideInput();
    });
    form.submit(function(e) {
      e.preventDefault();
      self.setLoading(true);
      var newFilename = $(this).find('input').val();
      $.ajax({
        url: p_tag.data('update-url'),
        type: 'PUT',
        data: { filename: newFilename },
        success: function(data) {
          form.siblings('p').text(data.filename);
          form.siblings('img').attr('data-uris', data.uris);
        },
        complete: function() {
          hideInput();
          self.setLoading(false);
        }
      });
    });
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
	$('body').on('click', '#items li img', function(e){
		browser.selectItem(e.target);
	});

	// fluid pagination
	$(window).scroll(function(){
		browser.loadNextPage();
	});

  // search bar, triggered after idling for 1 second
  var richSearchTimeout;
  $('#rich-search input').keyup(function() {
    clearTimeout(richSearchTimeout);
    var input = this;
    richSearchTimeout = setTimeout(function() {
      browser.performSearch($(input).val());
    }, 1000);
  });

  // filename update
  $('body').on('click', '#items li:not(#uploadBlock) p', function() {
    browser.showNameEditInput($(this));
  });

});
