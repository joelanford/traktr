module Traktr
  class Endpoint
    include HTTParty

    def initialize(client)
      self.class.base_uri File.join(Traktr.base_uri, self.class.to_s.split("::")[1..-1].join("/").downcase)
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    private

    def parse_response( response )
      raise ResponseError.new(response) if response.code != 200
      data = response.parsed_response
      if data.class == Array
        data.collect { |i| Mash.new(i) }
      elsif data.class == Hash
        Mash.new(data)
      elsif data.class == String
        #
        # TODO: Trakt's response header's "Content-Type" parameter is sometimes set to "text/html",
        #       but HTTParty needs it to be "application/json" to correctly parse.
        #
        #       Endpoints with this issue are:
        #        - 'lists/items/add'
        #        - 'movie/library'
        #        - 'movie/watchlist'
        #        - 'movie/seen'
        #        - 'show/watchlist'
        #
        Mash.new(JSON.parse(response))
      else
        data
      end
    end
  end
end
