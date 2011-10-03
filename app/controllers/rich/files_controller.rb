module Rich
  class FilesController < ApplicationController
    
    def index
      # list all files
      @images = RichImage.all
      
      # stub for new file
      @rich_image = RichImage.new
    end
    
    def create
      @rich_image = RichImage.new(params[:rich_image])
      if @rich_image.save
        flash[:notice] = "Successfully created image."
        redirect_to :action => 'index'
      else
        render :action => 'index'
      end
    end
    
    
  end
end
