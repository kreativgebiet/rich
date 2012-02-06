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
          builder.text_field(method, local_input_options.merge(input_html_options)) <<
          " <a href='#{Rich.editor[:richBrowserUrl]}' class='button'>#{I18n.t('picker_browse')}</a>".html_safe <<
          "</br></br><img class='rich-image-preview' src='#{@object.send(method)}' style='height: 100px' />".html_safe <<
          "<script>$(function(){$('##{input_html_options[:id]}_input a').click(function(e){ e.preventDefault(); assetPicker.showFinder('##{input_html_options[:id]}', #{editor_options.to_json.html_safe})})})</script>".html_safe

        end
      end

    end
    
end