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
  end
end