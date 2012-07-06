require 'rails/generators'
module Rich
  module Generators
    class InstallGenerator < Rails::Generators::Base
      
      desc "Installs Rich into your app. Get wealthy."
      
      def self.source_root
        @source_root ||= File.join(File.dirname(__FILE__), 'templates')
      end
      
      def copy_initializer
        template 'rich.rb.erb', 'config/initializers/rich.rb'
      end
      
      def setup_route
        route "mount Rich::Engine => '/rich', :as => 'rich'"
      end
      
      def install_editor_styles
        copy_file '../../../../../app/assets/stylesheets/rich/rich_editor.css', 'app/assets/stylesheets/rich/editor.css'
      end
      
      def install_javascript
        template 'rich.js', 'app/assets/javascripts/rich.js'
      end
      
      def create_migrations
        rake "rich:install:migrations"
      end
      
  end
 end
end