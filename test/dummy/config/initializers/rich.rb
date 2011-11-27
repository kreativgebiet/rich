require "rich"

if Object.const_defined?("Rich")
  
  Rich.setup do |config|    
    
    # Customize ckeditor by adding configuration to config.editor (you can use any ckeditor config directive)
    # Look at the Rich source for default settings. These settings can also be overridden per editor instance.
    # Example: config.editor[:skin] = 'office2003' # ill advice, but you get the idea
    # Example: config.editor[:startupOutlineBlocks] = false

    config.image_styles = {
      :large => "500x500",
      :thumb => "100x100#"
    }
    
    # config.allowed_styles = :all # this is the default - show all styles
    # config.allowed_styles = [ :large, :original ]
    # config.allowed_styles = [ :large, :thumb ]
    
    config.default_style = :large
    
    config.authentication_method = :authenticate_admin_user!
    
  end
  
  # activate Rich
  Rich.insert
end