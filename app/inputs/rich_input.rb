if (Object.const_defined?("Formtastic") && Gem.loaded_specs["formtastic"].version.version[0,1].to_i > 1)

  class RichInput < ::Formtastic::Inputs::TextInput
    def to_html

      scope_type = object_name
      scope_id = object.id
      editor_options = Rich.options(
                                  options[:config],
                                    options[:config].fetch(:scope_type, scope_type),
                                    options[:config].fetch(:scope_id, scope_id)
                                  )

      input_wrapping do
        label_html <<
        builder.text_area(method, input_html_options) <<
        "<script>CKEDITOR.replace('#{dom_id}', #{editor_options.to_json.html_safe});</script>".html_safe
      end
    end
  end

end

if Object.const_defined?("SimpleForm")
  class RichInput < SimpleForm::Inputs::TextInput
    def input
      scope_type = object_name
      scope_id = object.id
      editor_options = Rich.options(options[:config], scope_type, scope_id)

      super <<
      "<script>CKEDITOR.replace('#{object_name}_#{attribute_name}', #{editor_options.to_json.html_safe});</script>".html_safe
    end
  end
 end
