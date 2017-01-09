class RichInput < SimpleForm::Inputs::TextInput
  def input(wrapper_options)
    scope_type = object_name
    scope_id = object.id
    editor_options = Rich.options(options[:config], scope_type, scope_id)

    super <<
    "<script>CKEDITOR.replace('#{object_name}[#{attribute_name}]', #{editor_options.to_json.html_safe});</script>".html_safe
  end
end
