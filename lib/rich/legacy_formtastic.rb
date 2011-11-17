module Rich
  module FormtasticBuilder
    def self.included(base)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def rich_input(method, options)
        editor_options = Rich.editor.merge(options[:editor] || {})
        editor_options[:width]  = options[:width] || '76%'
        editor_options[:height] = options[:height] || '400px'
        dom_id = "#{sanitized_object_name}_#{generate_association_input_name(method)}"

        (
          text_input(method, options) <<
          "<script>$(function(){$('##{dom_id}').ckeditor(function() { }, #{editor_options.to_json} );});</script>".html_safe
        )
      end
    end
  end
end