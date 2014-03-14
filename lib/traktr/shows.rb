module Traktr
  class Shows
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'shows')

    def initialize(client)
      @client = client
      @auth = { :username => @client.username, :password => @client.password }
    end

    ##
    ## movies GET methods
    ##
    def trending
      response = self.class.get('/' + File.join('trending.json', @client.api_key), :basic_auth => @auth)
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |show|
        Mash.new(show)
      end
    end

    def updated(timestamp)
      timestamp = timestamp.class == Time ? timestamp.to_i.to_s : timestamp.to_s

      response = self.class.get('/' + File.join('updated.json', @client.api_key, timestamp))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

  end
end
