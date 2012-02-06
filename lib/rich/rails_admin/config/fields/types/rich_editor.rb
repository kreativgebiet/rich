#require 'rails_admin/config/fields/base'
module RailsAdmin::Config::Fields::Types
  class RichEditor < RailsAdmin::Config::Fields::Base
    RailsAdmin::Config::Fields::Types::register(:rich_editor, self)
    @view_helper = :text_area
        
    register_instance_option(:config) do
      {}
    end
    
    register_instance_option(:partial) do
      :form_rich_text
    end
        
    def scope_type
      bindings[:form].object_name
    end
    
    def scope_id
      bindings[:object].id
    end

  end
end