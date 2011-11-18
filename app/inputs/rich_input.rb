
if Object.const_defined?("Formtastic")
  if(Gem.loaded_specs["formtastic"].version.version[0,1] == "2")


    class RichInput < ::Formtastic::Inputs::TextInput  
      def to_html
        editor_options = Rich.editor.merge(options[:editor] || {})
        editor_options[:width]  = options[:width] || '76%'
        editor_options[:height] = options[:height] || '400px'

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
end

