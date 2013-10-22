module Traktr
  class Search
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'search')

    def initialize(client)
      @client = client
    end
    
    ##
    ## search GET methods
    ##
    def episodes(query)
      response = self.class.get('/' + File.join('episodes.json', @client.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def movies(query)
      response = self.class.get('/' + File.join('movies.json', @client.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def people(query)
      response = self.class.get('/' + File.join('people.json', @client.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def shows(query, limit = 30, seasons = nil)
      response = self.class.get('/' + File.join('shows.json', @client.api_key, URI::encode(query), limit.to_s, seasons.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def users(query)
      response = self.class.get('/' + File.join('users.json', @client.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

  end
end
