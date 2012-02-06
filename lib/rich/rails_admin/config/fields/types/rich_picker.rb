#require 'rails_admin/config/fields/types/string'
module RailsAdmin::Config::Fields::Types
  class RichPicker < RailsAdmin::Config::Fields::Base 
    RailsAdmin::Config::Fields::Types::register(:rich_picker, self)
    
    register_instance_option(:config) do
      {}
    end
      
    register_instance_option(:partial) do
      :form_rich_picker
    end
    
    
    def scope_type
      bindings[:form].object_name
    end
    
    def scope_id
      bindings[:object].id
    end
    
  end
end