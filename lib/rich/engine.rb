require 'paperclip'
require 'rack/raw_upload'
require "rich/authorize"
    
module Rich
  class Engine < Rails::Engine
    isolate_namespace Rich

    initializer "rich.add_middleware" do |app|
      config.assets.precompile << Proc.new do |path|
        if path =~ /\.(css|js)\z/
          full_path = Rails.application.assets.resolve(path).to_path
          app_assets_path = Rails.root.join('app', 'assets').to_path
          if full_path.starts_with? app_assets_path
            puts "including asset: " + full_path
            true
          else
            puts "excluding asset: " + full_path
            false
          end
        else
          false
        end
      end
      app.middleware.use 'Rack::RawUpload', :paths => ['/rich/files']
    end

    initializer 'rich.include_authorization' do |app|
      ActiveSupport.on_load(:action_controller) do
        include Rich::Authorize
      end
    end


  end
end
