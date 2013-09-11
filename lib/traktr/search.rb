module Traktr
  module Search
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'search')

    ##
    ## search GET methods
    ##
    def self.episodes(query)
      response = self.get('/' + File.join('episodes.json', Traktr.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def self.movies(query)
      response = self.get('/' + File.join('movies.json', Traktr.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def self.people(query)
      response = self.get('/' + File.join('people.json', Traktr.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def self.shows(query)
      response = self.get('/' + File.join('shows.json', Traktr.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

    def self.users(query)
      response = self.get('/' + File.join('users.json', Traktr.api_key, URI::encode(query)))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |result|
        Mash.new(result)
      end
    end

  end
end
