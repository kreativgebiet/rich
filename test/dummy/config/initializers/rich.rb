require "rich"

if Object.const_defined?("Rich")
  Rich.setup do |config|    
    
    # Customize ckeditor by adding configuration to config.editor (you can use any ckeditor config directive)
    #config.editor[:skin] = 'office2003' # ill advice, but you get the idea
    
    #STUB
    # Customize the models Rich will use for file uploads
    # if you used the generator, you shouldn't need to change these
    #config.image_model = 'Rich::ImageAsset'
    
    config.image_styles = {
      :large => "500x500",
      :thumb => "100x100#"
    }
    
    # config.allowed_styles = :all # this is the default - show all styles
    # config.allowed_styles = [ :large, :original ]
    config.allowed_styles = [ :large ]
    
    config.default_style = :large
    
  end
  
  # activate Rich
  Rich.insert
end