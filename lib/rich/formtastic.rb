module Rich
  class CustomFormBuilder < Formtastic::SemanticFormBuilder

    private

    def rich_input(method, options)
      html_options = options.delete(:input_html) || {}
      self.label(method, options_for_label(options)) <<
      self.send(:ckeditor_textarea, sanitized_object_name, method, html_options)
    end
  end
end
