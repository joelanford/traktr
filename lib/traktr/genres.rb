module Traktr
  class Genres < Endpoint
    def movies
      parse_response self.class.get(
        '/' + File.join('movies.json', @client.api_key)
      )
    end

    def shows
      parse_response self.class.get(
        '/' + File.join('shows.json', @client.api_key)
      )
    end
  end
end
