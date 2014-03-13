module Traktr
  class Server
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'server')

    def initialize(client)
      @client = client
    end

    ##
    ## server GET methods
    ##
    def time
      response = self.class.get('/' + File.join('time.json', @client.api_key))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end
