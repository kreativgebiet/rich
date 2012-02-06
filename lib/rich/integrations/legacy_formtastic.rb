module Rich
  module Integrations
    module FormtasticBuilder
      def self.included(base)
        base.send(:include, InstanceMethods)
      end

      module InstanceMethods
        def rich_input(method, options)
          scope_type = object_name
          scope_id = object.id
          editor_options = Rich.options(options[:config], scope_type, scope_id)
          dom_id = "#{sanitized_object_name}_#{generate_association_input_name(method)}"

          (
            text_input(method, options) <<
            "<script>$(function(){$('##{dom_id}').ckeditor(function() { }, #{editor_options.to_json} );});</script>".html_safe
          )
        end

        def rich_picker_input(method, options)

          scope_type = object_name
          scope_id = object.id
          editor_options = Rich.options(options[:config], scope_type, scope_id)

          dom_id = "#{sanitized_object_name}_#{generate_association_input_name(method)}"

          local_input_options = {
            :input_html => {
                :class => 'rich-picker',
                :style => editor_options[:style]
            }
          }

          (
            string_input(method, local_input_options) <<
            " <a href='#{Rich.editor[:richBrowserUrl]}' class='button'>#{I18n.t('picker_browse')}</a>".html_safe <<
            "</br></br><img class='rich-image-preview' src='#{@object.send(method)}' style='height: 100px' />".html_safe <<
            "<script>$(function(){$('##{dom_id}_input a').click(function(e){ e.preventDefault(); assetPicker.showFinder('##{dom_id}', #{editor_options.to_json.html_safe})})})</script>".html_safe <<
            options.inspect

          )

        end

      end
    end
  end
end