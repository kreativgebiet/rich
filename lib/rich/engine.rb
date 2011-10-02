module Rich
  class Engine < Rails::Engine
    isolate_namespace Rich
    
    require 'rack/raw_upload'
    config.middleware.use 'Rack::RawUpload', :paths => ['/rich/files'] # TODO make this path the engine mountpoint
    
  end
end
