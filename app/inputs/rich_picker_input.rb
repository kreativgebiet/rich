if (Object.const_defined?("Formtastic") && Gem.loaded_specs["formtastic"].version.version[0,1] == "2")

    class RichPickerInput < ::Formtastic::Inputs::StringInput
      include Formtastic::Helpers::InputHelper
      attr_reader :editor_options

      def to_html
        @editor_options = Rich.options(options[:config], object_name, object.id)

        local_input_options = {
          :class => 'rich-picker',
          :style => editor_options[:style]
        }

        input_wrapping do
          # where is the label!? -RH
          label_html <<
          if editor_options[:hidden_input] == true
            field = builder.hidden_field(method, local_input_options.merge(input_html_options))
          else
            field = builder.text_field(method, local_input_options.merge(input_html_options))
          end

          field << button
          field << preview
          field << javascript
        end
      end
private
      def image_path
        method_value = object.send(method)
        return unless method_value.present?
        # TODO: need the asset path for this thing--or just use CSS & add a class -RH
        # return editor_options[:document_thumb] if editor_options[:type].to_s == 'file'
        return if editor_options[:type].to_s == 'file'

        # using Formtastic::Helpers::InputHelper#column_type
        #   should be :string or :integer -RH
        column_type = column_for(method).type
        if column_type == :integer
          file = Rich::RichFile.find(method_value)
          file.rich_file
        else # should be :string
          method_value
        end
      end

      def button
        %Q{
            <a href='#{Rich.editor[:richBrowserUrl]}' class='button'>
              #{I18n.t('picker_browse')}
            </a>
        }.html_safe
      end

      def javascript
        %Q{
            <script>
              $(function(){
                $('##{input_html_options[:id]}_input a').click(function(e){
                  e.preventDefault(); assetPicker.showFinder('##{input_html_options[:id]}', #{editor_options.to_json})
                });
              });
            </script>
        }.html_safe
      end

      def preview
        path = image_path
        klass = "class='rich-image-preview'"
        style = "style='max-width:#{editor_options[:preview_size]}; max-height:#{editor_options[:preview_size]};'"
        if path
          %Q{
             </br></br><img src='#{image_path}' #{klass} #{style} />
          }.html_safe
        else
          %Q{
             </br></br><div #{klass} #{style}></div>
          }.html_safe
        end
      end
    end

end
