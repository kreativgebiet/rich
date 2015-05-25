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

    def editor_options
      Rich.options(config, scope_type, scope_id)
    end

    def preview_image_path
      if value.to_s.html_safe != ""
        if (true if Float(value) rescue false)
          # if the value is numeric we assume its an object id
          rich_file = Rich::RichFile.find(value)
          rich_file.rich_file.url(:rich_thumb)
        else
          # if not, we assume its a url
          value.to_s
        end
      else
        # no value, show placeholder image
        editor_options[:placeholder_image]
      end

    end

  end
end