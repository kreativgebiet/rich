module Rich
  module ViewHelper
    include ActionView::Helpers
    
    def rich_textarea(object, field, options = {})
      options = options.dup.symbolize_keys
      
      var = options.delete(:object) if options.key?(:object)
      var ||= @template.instance_variable_get("@#{object}")
      
      value = var.send(field.to_sym) if var
      value ||= options.delete(:value) || ""
      
      element_id = options.delete(:id) || editor_element_id(object, field, options.delete(:index))
      width  = options.delete(:width) || '100%'
      height = options.delete(:height) || '100%'
      
      textarea_options = { :id => element_id }
      
      textarea_options[:cols]  = (options.delete(:cols) || 70).to_i
      textarea_options[:rows]  = (options.delete(:rows) || 20).to_i
      textarea_options[:class] = (options.delete(:class) || 'editor').to_s
      textarea_options[:style] = "width:#{width};height:#{height}"
      
      # merge options with Rich.ckeditor
      editor_options = Rich.editor.merge(options[:editor] || {})
      editor_options[:width]  = width;
      editor_options[:height] = height;
            
      output_buffer = ActiveSupport::SafeBuffer.new
      output_buffer << ActionView::Base::InstanceTag.new(object, field, self, var).to_text_area_tag(textarea_options.merge(options))
      
      # lookin' like wealth.
      output_buffer << javascript_tag("$(function(){$('##{element_id}').ckeditor(function() { }, #{editor_options.to_json} );});")
      
      output_buffer
    end
    
    protected
    
    # construct a unique ID  
    def editor_element_id(object, field, index = nil)
      index.blank? ? "#{object}_#{field}_editor" : "#{object}_#{index}_#{field}_editor"
    end
    
  end
end