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
    
    def create
      
      #render :json => { :success => false, :error => "File is too large..." }
      render :json => { :success => true }
      
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
    
    
  end
end
