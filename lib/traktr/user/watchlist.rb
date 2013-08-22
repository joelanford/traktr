module Traktr
  module User
    module Watchlist
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'watchlist')

      def self.episodes(username = Traktr.username)
        response = self.get('/' + File.join('episodes.json', Traktr.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def self.movies(username = Traktr.username)
        response = self.get('/' + File.join('movies.json', Traktr.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def self.shows(username = Traktr.username)
        response = self.get('/' + File.join('shows.json', Traktr.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
