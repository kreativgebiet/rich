module Rich
  module FilesHelper
    
    def thumb_for_file(file)
      if file.image?
        file.rich_file.url(:thumb)
      else
        asset_path "rich/missing.png"
      end
    end
    
  end
end
