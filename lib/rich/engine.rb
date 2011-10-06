require 'paperclip'
require 'rack/raw_upload'
    
module Rich
  class Engine < Rails::Engine
    isolate_namespace Rich

    initializer "rich.add_middleware" do |app|
        app.middleware.use 'Rack::RawUpload', :paths => ['/rich/files'] # TODO make this path the engine mountpoint
    end
    
  end
end
