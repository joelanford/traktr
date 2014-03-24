module Traktr
  class User
    class Library
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'library')

      def initialize(client)
        @client = client
      end

      def movies
      	@movies ||= Traktr::User::Library::Movies.new(@client)
      end

      def shows
      	@shows ||= Traktr::User::Library::Shows.new(@client)
      end
    end
  end
end
