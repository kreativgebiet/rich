require "rich/engine"

module Rich
 
  # specify desired image styles here  
  mattr_accessor :image_styles
  @@image_styles = {
    :thumb => "100x100#"
  }  
  
  mattr_accessor :allowed_styles
  @@allowed_styles = :all
  
  mattr_accessor :default_style
  @@default_style = :thumb
  
  mattr_accessor :authentication_method
  @@authentication_method = :none
  
  mattr_accessor :insert_many_images
  @@insert_many_images = false
  
  # Configuration defaults (these map directly to ckeditor settings)
  mattr_accessor :editor
  @@editor = {
    :stylesSet  =>  [],
    :extraPlugins => 'stylesheetparser,richimage',
    :removePlugins => 'scayt,menubutton,contextmenu,image,forms',
    :contentsCss => '/assets/rich/editor.css', # TODO: make this map to the engine mount point
    :removeDialogTabs => 'link:advanced;link:target',
    :startupOutlineBlocks => true,
    :forcePasteAsPlainText => true,
    :format_tags => 'h3;p;pre',
    :toolbar => [['Format','Styles'],['Bold', 'Italic', '-','NumberedList', 'BulletedList', 'Blockquote', '-', 'richImage', '-', 'Link', 'Unlink'],['Source', 'ShowBlocks']],
    
    :richImageUrl => '/rich/files/', #todo make this map to the engine mount point
    
    :uiColor => '#f4f4f4' # similar to Active Admin
  }
  # End configuration defaults
  
  def self.setup
    yield self
  end
  
  def self.insert
    # manually inject into Formtastic 1. V2 is extended autmatically.
    if Object.const_defined?("Formtastic")
      if(Gem.loaded_specs["formtastic"].version.version[0,1] == "1")
        require 'rich/integrations/legacy_formtastic'
        ::Formtastic::SemanticFormBuilder.send :include, Rich::Integrations::FormtasticBuilder
      end
    end
  end
  
end