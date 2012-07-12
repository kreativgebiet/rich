module Rich
  module Authorize
    def authenticate_rich_user
      send(Rich.authentication_method) unless Rich.authentication_method == :none
    end
  end
end