module Traktr
  module User
    module Watchlist
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'watchlist')

      def episodes(username = @client.username)
        response = self.class.get('/' + File.join('episodes.json', @client.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def movies(username = @client.username)
        response = self.class.get('/' + File.join('movies.json', @client.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def shows(username = @client.username)
        response = self.class.get('/' + File.join('shows.json', @client.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
