require "rich/engine"

module Rich
  autoload :ViewHelper, 'rich/view_helper'
  
  # Configuration defaults (these map directly to ckeditor settings)
  mattr_accessor :skin
  @@skin = "office2003"
  # End configuration defaults
  
  def self.setup
    yield self
  end
  
  def self.insert
    
    ActionView::Base.send(:include, Rich::ViewHelper)
  end
  
end
