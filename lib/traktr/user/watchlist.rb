module Traktr
  class User
    class Watchlist < Endpoint
      def episodes(username = @client.username)
        parse_response self.class.get('/' + File.join('episodes.json', @client.api_key, username))
      end

      def movies(username = @client.username)
        parse_response self.class.get('/' + File.join('movies.json', @client.api_key, username))
      end

      def shows(username = @client.username)
        parse_response self.class.get('/' + File.join('shows.json', @client.api_key, username))
      end
    end
  end
end
