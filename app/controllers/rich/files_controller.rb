module Rich
  class FilesController < ApplicationController

    before_action :authenticate_rich_user
    before_action :set_rich_file, only: [:show, :update, :destroy]

    layout "rich/application"

    def index
      @type = params[:type]

      @items = case @type
      when 'file'
        RichFile.files
      when 'image'
        RichFile.images
      when 'video'
        RichFile.videos
      end

      if params[:scoped] == 'true'
        @items = @items.where("owner_type = ? AND owner_id = ?", params[:scope_type], params[:scope_id])
      end

      if params[:search].present?
        @items = @items.where('rich_file_file_name LIKE ?', "%#{params[:search]}%")
      end

      if params[:alpha].present?
        @items = @items.order("rich_file_file_name ASC")
      else
        @items = @items.order("created_at DESC")
      end

      @items = @items.page params[:page]

      # stub for new file
      @rich_asset = RichFile.new

      respond_to do |format|
        format.html
        format.js
      end

    end

    def show
      # show is used to retrieve single files through XHR requests after a file has been uploaded

      if(params[:id])
        # list all files
        @file = @rich_file
        render :layout => false
      else
        render :text => "File not found"
      end

    end

    def create
      # use the file from Rack Raw Upload
      file_params = params.fetch(:rich_file, {}).fetch(:rich_file, nil) || (params[:qqfile].is_a?(ActionDispatch::Http::UploadedFile) ? params[:qqfile] : params[:file] )

      # simplified_type is only passed through via JS
      # if using the legacy uploader, we need to determine file type via ActionDispatch::Http::UploadedFile#content_type so the validations on @file do not fail
      sim_file_type = if params[:simplified_type].present?
        params[:simplified_type]
      elsif file_params.content_type =~ /image/i
        'image'
      elsif file_params.content_type =~ /video/i
        'video'
      elsif file_params.content_type =~ /file/i
        'file'
      else
        'file'
      end

      @file = RichFile.new(simplified_type: sim_file_type)

      if(params[:scoped] == 'true')
        @file.owner_type = params[:scope_type]
        @file.owner_id = params[:scope_id].to_i
      end

      if(file_params)
        file_params.content_type = Mime::Type.lookup_by_extension(file_params.try(:original_filename).try(:split, '.').try(:last).try(:to_sym) || params[:file] || params[:qqfile])
        @file.rich_file = file_params
      end

      if @file.save
        response = { success: true, rich_id: @file.id }
      else
        response = { success: false,
                     error: "Could not upload your file:\n- "+@file.errors.to_a[-1].to_s,
                     params: params.inspect }
      end

      render json: response, content_type: "text/html"
    end

    def update
      new_filename_without_extension = params[:filename].parameterize
      if new_filename_without_extension.present?
        new_filename = @rich_file.rename!(new_filename_without_extension)
        render :json => { :success => true, :filename => new_filename, :uris => @rich_file.uri_cache }
      else
        render :nothing => true, :status => 500
      end
    end

    def destroy
      if(params[:id])
        @rich_file.destroy
        @fileid = params[:id]
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_rich_file
        @rich_file = RichFile.find(params[:id])
      end
  end
end
