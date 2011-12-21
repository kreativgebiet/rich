require 'rails_admin/config/fields/types/string'

module Rich
  module Integrations
    module RailsAdmin
      class RichPicker < ::RailsAdmin::Config::Fields::Base
        
        register_instance_option(:config) do
          {}
        end
      
        register_instance_option(:partial) do
          :form_rich_picker
        end

      end
    end
  end
end