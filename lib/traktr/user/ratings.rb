module Traktr
  class User
    class Ratings < Endpoint
      def episodes(username = @client.username, rating = :all, extended = :min)
        parse_response self.class.get(
          '/' + File.join('episodes.json', @client.api_key, username,
                          rating.to_s, extended.to_s)
        )
      end

      def movies(username = @client.username, rating = :all, extended = :min)
        parse_response self.class.get(
          '/' + File.join('movies.json', @client.api_key, username,
                          rating.to_s, extended.to_s)
        )
      end

      def shows(username = @client.username, rating = :all, extended = :min)
        parse_response self.class.get(
          '/' + File.join('shows.json', @client.api_key, username,
                          rating.to_s, extended.to_s)
          )
      end
    end
  end
end
