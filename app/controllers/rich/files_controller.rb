module Rich
  class FilesController < ApplicationController
    
    def index      
      if (Rich.allowed_styles == :all)
        @styles = Rich.image_styles.keys
        @styles.push(:original)
      else 
        @styles = Rich.allowed_styles
      end
      
      @default_style = Rich.default_style
      
      # list all files
      @images = RichImage.order("created_at DESC").page params[:page]
      
      # stub for new file
      @rich_image = RichImage.new
      
      respond_to do |format|
        format.js
        format.html
      end
      
    end
    
    def show
      # show is used to retrieve single images through XHR requests after an image has been uploaded
      
      if(params[:id])
        # list all files
        @file = RichImage.find(params[:id])
        render :layout => false
      else 
        render :text => "Image not found"
      end
      
    end
    
    def create
      @file = RichImage.new
      
      # use the file from Rack Raw Upload
      if(params[:file])
        @file.image = params[:file]
      end
      
      if @file.save
        render :json => { :success => true, :rich_id => @file.id }
      else
        render :json => { :success => false, 
                          :error => "Could not upload your file:\n- "+@file.errors.to_a[-1].to_s,
                          :params => params.inspect }
      end
    end
    
    def destroy  
      if(params[:id])
        image = RichImage.delete(params[:id])
        @fileid = params[:id]
      end
    end
    
  end
end
