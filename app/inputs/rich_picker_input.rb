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
            img = bimage_tag(Rich::RichFile.find(@object.send(method)).rich_file, :class => 'rich-image-preview', :style => 'max-width: 100px;')
          else
            field = builder.text_field(method, local_input_options.merge(input_html_options)) 
            img = image_tag(@object.send(method), :class => 'rich-image-preview', :style => 'max-width: 100px;')
          end

          field  <<
          " <a href='#{Rich.editor[:richBrowserUrl]}' class='button'>#{I18n.t('picker_browse')}</a>".html_safe <<
          img <<
          "<script>$(function(){$('##{input_html_options[:id]}_input a').click(function(e){ e.preventDefault(); assetPicker.showFinder('##{input_html_options[:id]}', #{editor_options.to_json.html_safe})})})</script>".html_safe

        end
      end

    end
    
end