module Rich
  class FilesController < ApplicationController
    
    def index
      # list all files
      @images = RichImage.all
      
      # stub for new file
      @rich_image = RichImage.new
    end
    
    def create
      
      # inject the uploaded image into the page with JS
      
      render :text, params.inspect
      
      # @rich_image = RichImage.new(params[:rich_image])
      #       if @rich_image.save
      #         flash[:notice] = "Successfully created image."
      #         redirect_to :action => 'index'
      #       else
      #         redirect_to :action => 'index'
      #       end
    end
    
    
  end
end
