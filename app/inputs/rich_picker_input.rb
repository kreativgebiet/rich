if (Object.const_defined?("Formtastic") && Gem.loaded_specs["formtastic"].version.version[0,1] == "2")
    
    class RichPickerInput < ::Formtastic::Inputs::StringInput

      def to_html 
        scope_type = object_name
        scope_id = object.id
        editor_options = Rich.options(options[:config], scope_type, scope_id)
        
        local_input_options = {
          :class => 'rich-picker',
          :style => editor_options[:style]
        }

        input_wrapping do

          label_html <<
          if editor_options[:hidden_input] == true
            field = builder.hidden_field(method, local_input_options.merge(input_html_options)) 
            if scope_id
              rich_file = Rich::RichFile.find(scope_id)
              img_path = rich_file.rich_file(editor_options[:preview_size])
              if editor_options[:preview_size]
                img_width = rich_file.set_styles[editor_options[:preview_size]].split('x').first
              end
            end
          else
            field = builder.text_field(method, local_input_options.merge(input_html_options)) 
            img_path = editor_options[:placeholder_image]
          end

          field  <<
          " <a href='#{Rich.editor[:richBrowserUrl]}' class='button'>#{I18n.t('picker_browse')}</a>".html_safe <<
          "</br></br><img class='rich-image-preview' src='#{img_path}' width='#{img_width}'/>".html_safe <<
          "<script>$(function(){$('##{input_html_options[:id]}_input a').click(function(e){ e.preventDefault(); assetPicker.showFinder('##{input_html_options[:id]}', #{editor_options.to_json.html_safe})})})</script>".html_safe

        end
      end

    end
    
end