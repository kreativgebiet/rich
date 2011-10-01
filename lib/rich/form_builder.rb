module Rich
  module FormBuilder
    def self.included(base)
      base.send(:include, Rich::ViewHelper)
      base.send(:include, Rich::FormBuilder::ClassMethods)
    end
    
    module ClassMethods
		  def rich_text_area(method, options = {})
      	rich_textarea(@object_name, method, objectify_options(options))
      end
    end
  end
end
