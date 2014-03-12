module Traktr
  class Genres
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'genres')

    def initialize(client)
      @client = client
    end

    ##
    ## genres GET methods
    ##
    def movies
      response = self.class.get('/' + File.join('movies.json', @client.api_key))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def shows
      response = self.class.get('/' + File.join('shows.json', @client.api_key))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

  end
end
