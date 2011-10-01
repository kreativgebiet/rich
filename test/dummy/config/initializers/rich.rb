if Object.const_defined?("Rich")
  Rich.setup do |config|    
    
    # Customize ckeditor by adding configuration to config.editor (you can use any ckeditor config directive)
    #config.editor[:skin] = 'office2003' # ill advice, but you get the idea
    
    #STUB
    # Customize the models Rich will use for file uploads
    # if you used the generator, you shouldn't need to change these
    #config.image_model = 'Rich::ImageAsset'
    
  end
  
  # activate Rich
  Rich.insert
end