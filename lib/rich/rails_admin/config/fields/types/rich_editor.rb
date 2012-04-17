#require 'rails_admin/config/fields/base'
module RailsAdmin::Config::Fields::Types
  class RichEditor < RailsAdmin::Config::Fields::Types::Text
    RailsAdmin::Config::Fields::Types::register(:rich_editor, self)
        
    register_instance_option(:config) do
      {}
    end
    
    register_instance_option(:partial) do
      :form_rich_text
    end

    def scope_type

      # Use association name if existent
      if bindings[:form].object_name.scan(/.*\[(.*)_attributes\]/).nil?
        bindings[:form].object_name
      else
        bindings[:form].object_name.scan(/.*\[(.*)_attributes\]/).to_s
      end
    end

    def scope_id
      bindings[:object].id
    end

  end
end