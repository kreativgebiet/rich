#require 'rails_admin/config/fields/base'
module RailsAdmin::Config::Fields::Types
  class RichEditor < RailsAdmin::Config::Fields::Types::Text
    RailsAdmin::Config::Fields::Types::register(:rich_editor, self)

    register_instance_option(:config) do
      {}
    end

    register_instance_option(:partial) do
      :form_rich_text
    end

    def scope_type
      return nil unless bindings && bindings[:form]
      # Use association name if existent
      if bindings[:form].object_name.scan(/.*\[(.*)_attributes\]/).nil?
        bindings[:form].object_name
      else
        bindings[:form].object_name.scan(/.*\[(.*)_attributes\]/).to_s
      end
    end

    # Compatibility with RailsAdmin 0.6.0 AND prior versions
    # https://github.com/sferik/rails_admin/commit/494205b3a0e128bfc98084ac59b5ee378d3218a1
    def form_default_value
      self.respond_to?(:html_default_value) ? html_default_value : super
    end

    def scope_id
      bindings[:object].id
    end
  end
end
