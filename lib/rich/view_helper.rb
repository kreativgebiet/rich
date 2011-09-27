module Rich
  module ViewHelper
    include ActionView::Helpers
    
    def rich_text_area(object, field, options = {})
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
      
      output_buffer = ActiveSupport::SafeBuffer.new
      output_buffer << ActionView::Base::InstanceTag.new(object, field, self, var).to_text_area_tag(textarea_options.merge(options))
      
      
      # output_buffer << javascript_tag("if (CKEDITOR.instances['#{element_id}']) { 
      #   CKEDITOR.remove(CKEDITOR.instances['#{element_id}']);}
      #   CKEDITOR.replace('#{element_id}', { #{ckeditor_applay_options(ckeditor_options)} });")
      
      output_buffer << javascript_tag("$(function(){$('##{element_id}').ckeditor();});")
      
      output_buffer
      
      #$('textarea.ckeditor').ckeditor();"
    end
    
    protected
      
    def editor_element_id(object, field, index = nil)
      index.blank? ? "#{object}_#{field}_editor" : "#{object}_#{index}_#{field}_editor"
    end
    
    
  end
end