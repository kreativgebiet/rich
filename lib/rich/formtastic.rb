module Rich
  module FormtasticBuilder
    def self.included(base)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def rich_input(method, options)
        html_options = options.delete(:input_html) || {}
        self.label(method, options_for_label(options)) <<
        self.send(:rich_textarea, sanitized_object_name, method, html_options)
      end
    end
  end
end