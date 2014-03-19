module Traktr
  class User
    class Library
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'library')
    end
  end
end
