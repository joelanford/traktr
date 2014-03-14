module Traktr
  class Search
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'search')

    def initialize(client)
      @client = client
      @auth = { :username => @client.username, :password => @client.password }
    end
    
    ##
    ## search GET methods
    ##
    def episodes(query, limit = 30)
      response = self.class.get('/' + File.join('episodes.json', @client.api_key, URI::encode(query), limit.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def movies(query, limit = 30)
      response = self.class.get('/' + File.join('movies.json', @client.api_key, URI::encode(query), limit.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def people(query, limit = 30)
      response = self.class.get('/' + File.join('people.json', @client.api_key, URI::encode(query), limit.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def shows(query, limit = 30, seasons = nil)
      seasons = seasons == nil || seasons == false ? "" : "seasons"

      response = self.class.get('/' + File.join('shows.json', @client.api_key, URI::encode(query), limit.to_s, seasons))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def users(query, limit = 30)
      response = self.class.get('/' + File.join('users.json', @client.api_key, URI::encode(query), limit.to_s), :basic_auth => @auth)
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

  end
end
