module Rich
  class ApplicationController < ActionController::Base
    
    before_filter :authenticate_rich_user
    
    def authenticate_rich_user
      send(Rich.authentication_method) unless Rich.authentication_method == :none
    end
    
  end
end
