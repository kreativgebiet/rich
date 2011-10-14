module Rich
  module FormtasticBuilder
    def self.included(base)
      base.send(:include, InstanceMethods)
    end

    module InstanceMethods
      def rich_input(method, options)
        basic_input_helper(:rich_textarea, :text, method, options)
      end
    end
  end
end