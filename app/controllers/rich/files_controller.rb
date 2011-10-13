module Rich
  class FilesController < ApplicationController
    
    def index
      # all available styles
      @styles = Rich.image_styles
      
      # list all files
      @images = RichImage.all
      
      # stub for new file
      @rich_image = RichImage.new
    end
    
    def show
      # show is used to retrieve single images through XHR requests after an image has been uploaded
      
      if(params[:id])
        # list all files
        @image = RichImage.find(params[:id])
        render :layout => false
      else 
        render :text => "Image not found"
      end
      
    end
    
    def create
      #render :json => { :success => false, :error => "File is too large..." }
      render :json => { :success => true, :rich_id => 1 }
      
      # if @article.save
      #       if is_qq
      #         render :json => { "success" => true }
      #       else
      #         # as before, likely:
      #         # redirect_to(articles_path, :notice => "Article was successfully created.")
      #       end
      #     else
      #       if is_qq
      #         render :json => { "error" => @article.errors }
      #       else
      #         # as before, likely:
      #         # render :action => :new
      #       end
      #     end
      
      # @rich_image = RichImage.new(params[:rich_image])
      #       if @rich_image.save
      #         flash[:notice] = "Successfully created image."
      #         redirect_to :action => 'index'
      #       else
      #         redirect_to :action => 'index'
      #       end
    end
    
    def delete
      
      render :text => "Hello"
      # delete an image
      
      # if(params[:id])
      #   # list all files
      #   @image = RichImage.find(params[:id])
      #   #render :layout => false
      #   # render js
      # 
      # else 
      #   render :text => "Image not found"
      # end
    end
    
  end
end
