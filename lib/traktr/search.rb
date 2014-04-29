module Traktr
  class Search < Endpoint
    def episodes(query, limit = 30)
      parse_response self.class.get('/' + File.join('episodes.json', @client.api_key, URI.encode(query), limit.to_s))
    end

    def movies(query, limit = 30)
      parse_response self.class.get('/' + File.join('movies.json', @client.api_key, URI.encode(query), limit.to_s))
    end

    def people(query, limit = 30)
      parse_response self.class.get('/' + File.join('people.json', @client.api_key, URI.encode(query), limit.to_s))
    end

    def shows(query, limit = 30, seasons = nil)
      seasons = seasons.nil? || seasons == false ? '' : 'seasons'
      parse_response self.class.get('/' + File.join('shows.json', @client.api_key, URI.encode(query), limit.to_s, seasons))
    end

    def users(query, limit = 30)
      parse_response self.class.get('/' + File.join('users.json', @client.api_key, URI.encode(query), limit.to_s), basic_auth: @auth)
    end
  end
end
