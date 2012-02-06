if (Object.const_defined?("Formtastic") && Gem.loaded_specs["formtastic"].version.version[0,1] == "2")

  class RichInput < ::Formtastic::Inputs::TextInput  
    def to_html

      scope_type = object_name
      scope_id = object.id
      editor_options = Rich.options(options[:config], scope_type, scope_id)

      input_wrapping do
        label_html <<
        builder.text_area(method, input_html_options) <<
        #javascript_tag("$(function(){$('##{dom_id}').ckeditor(function() { }, #{editor_options.to_json} );});")
        # doing this might be insecure?
        "<script>$(function(){$('##{dom_id}').ckeditor(function() { }, #{editor_options.to_json} );});</script>".html_safe
      end
    end
  end

end

