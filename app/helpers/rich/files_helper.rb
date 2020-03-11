module Rich
  module FilesHelper

    def thumb_for_file(file)
      if file.simplified_type == "image"
        file.rich_file.url(:rich_thumb)
      elsif file.simplified_type == "video"
        file.rich_file.url(:video_thumb)
      # elsif file.simplified_type == "file"
      #   file.rich_file.url(:file_thumb)
      else
        asset_path "rich/document-thumb.png"
      end
    end

  end
end
