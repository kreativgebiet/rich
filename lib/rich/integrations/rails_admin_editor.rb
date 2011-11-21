require 'rails_admin/config/fields/base'

module Rich
  module Integrations
    module RailsAdmin
      class RichEditor < ::RailsAdmin::Config::Fields::Base
        @view_helper = :text_area
        
        register_instance_option(:config) do
          {}
        end
      
        register_instance_option(:partial) do
          :form_rich_text
        end

      end
    end
  end
end