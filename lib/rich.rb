require "rich/engine"

module Rich
  autoload :ViewHelper, 'rich/view_helper'
  autoload :FormBuilder, 'rich/form_builder'
  autoload :FormtasticBuilder, 'rich/formtastic'
  
  # specify desired image styles here  
  mattr_accessor :image_styles
  @@image_styles = {
    :thumb => "100x100#"
  }  
  
  mattr_accessor :allowed_styles
  @@allowed_styles = :all
  
  mattr_accessor :default_style
  @@default_style = :thumb
  
  # Configuration defaults (these map directly to ckeditor settings)
  mattr_accessor :editor
  @@editor = {
    :stylesSet  =>  [],
    :extraPlugins => 'stylesheetparser,richimage',
    :removePlugins => 'scayt,menubutton,contextmenu,image,forms',
    :contentsCss => '/assets/rich/editor.css', # TODO: make this map to the engine mount point
    :removeDialogTabs => 'link:advanced;link:target',
    :startupOutlineBlocks => true,
    :format_tags => 'h3;p;pre',
    :toolbar => [['Format','Styles'],['Bold', 'Italic', '-','NumberedList', 'BulletedList', 'Blockquote', '-', 'richImage', '-', 'Link', 'Unlink'],['PasteFromWord'],['Source', 'ShowBlocks']],
    
    :richImageUrl => '/rich/files/', #todo make this map to the engine mount point
    
    :uiColor => '#f4f4f4' # similar to Active Admin
  }
  # End configuration defaults
  
  def self.setup
    yield self
  end
  
  def self.insert
    
    # TODO: link asset to user definable entity <%= form.cktext_area :content, :swf_params=>{:assetable_type=>'User', :assetable_id=>current_user.id} %>
    ActionView::Base.send(:include, Rich::ViewHelper)
    ActionView::Helpers::FormBuilder.send(:include, Rich::FormBuilder)
    
    # TODO: upgrade to formtastic 2 when Active Admin supports it
    if Object.const_defined?("Formtastic")
      #Formtastic::SemanticFormHelper.builder = Rich::CustomFormBuilder
      ::Formtastic::SemanticFormBuilder.send :include, Rich::FormtasticBuilder
    end
        
  end
  
end