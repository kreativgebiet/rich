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
  
  mattr_accessor :insert_many
  @@insert_many = false
  
  # Configuration defaults (these map directly to ckeditor settings)
  mattr_accessor :editor
  @@editor = {
    :stylesSet  =>  [],
    :extraPlugins => 'stylesheetparser,richimage',
    :removePlugins => 'scayt,menubutton,contextmenu,image,forms',
    :contentsCss => '/assets/rich/editor.css',
    :removeDialogTabs => 'link:advanced;link:target',
    :startupOutlineBlocks => true,
    :forcePasteAsPlainText => true,
    :format_tags => 'h3;p;pre',
    :toolbar => [['Format','Styles'],['Bold', 'Italic', '-','NumberedList', 'BulletedList', 'Blockquote', '-', 'richImage', '-', 'Link', 'Unlink'],['Source', 'ShowBlocks']],
    
    :richBrowserUrl => '/rich/files/',
    
    :uiColor => '#f4f4f4'
  }
  # End configuration defaults
  
  def self.options(overrides={})
    # merge in editor settings configured elsewhere
    
    if(self.allowed_styles == :all)
      # replace :all with a list of the actual styles that are present
      all_styles = Rich.image_styles.keys
      all_styles.push(:original)
      self.allowed_styles = all_styles
    end
    
    base = {
      :allowed_styles => self.allowed_styles,
      :default_style => self.default_style,
      :insert_many => self.insert_many
    }
    editor_options = self.editor.merge(base)
       
    # merge in local overrides
    editor_options.merge!(overrides) if overrides
    
    editor_options

  end
  
  def self.simplified_type_for(mime)
      #todo: abstract this array into something configurable
    if ['image/jpeg', 'image/png', 'image/gif', 'image/jpg'].include?(mime)
      "image"
    else
      "file"
    end
  end
  
  def self.is_allowed_type(simplified_type)
    true
  end
  
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
