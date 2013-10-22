module Traktr
  class Shows
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'shows')

    def initialize(client)
      @client = client
    end

    ##
    ## movies GET methods
    ##
    def trending
      response = self.class.get('/' + File.join('trending.json', @client.api_key))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |show|
        Mash.new(show)
      end
    end

    def updated(timestamp)
      response = self.class.get('/' + File.join('updated.json', @client.api_key, timestamp.to_i.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

  end
end
