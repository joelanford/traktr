module Traktr
  module User
    module Library
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'library')
    end
  end
end

require 'traktr/user/library/movies'
require 'traktr/user/library/shows'
