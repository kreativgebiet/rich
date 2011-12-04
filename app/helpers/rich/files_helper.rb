module Rich
  module FilesHelper
    
    def thumb_for_file(file)
      if file.simplified_type == "image"
        file.rich_file.url(:thumb)
      else
        asset_path "rich/document-thumb.png"
      end
    end
    
  end
end
