module Traktr
  class User
    class Library < Endpoint
      def movies
      	@movies ||= Traktr::User::Library::Movies.new(@client)
      end

      def shows
      	@shows ||= Traktr::User::Library::Shows.new(@client)
      end
    end
  end
end
