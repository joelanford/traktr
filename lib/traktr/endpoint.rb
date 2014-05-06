module Traktr
  class Endpoint
    include HTTParty

    def initialize(client)
      self.class.base_uri(
        File.join(Traktr.base_uri,
                  self.class.to_s.split('::')[1..-1].join('/').downcase)
      )
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    private

    def parse_response(response)
      #
      # TODO: Trakt's response header's "Content-Type" parameter is sometimes
      #       set to "text/html", which results in a String type being returned
      #       by response.parsed_response, but HTTParty needs it to be
      #       "application/json" to correctly parse into an Array or Hash.
      #
      #       Endpoints with this issue are:
      #        - 'lists/items/add'
      #        - 'movie/library'
      #        - 'movie/watchlist'
      #        - 'movie/seen'
      #        - 'show/watchlist'
      #
      fail ResponseError.new(response) if response.code != 200
      data = response.parsed_response

      case data.class
      when Array then data.map { |i| Mash.new(i) }
      when Hash then Mash.new(data)
      when String then Mash.new(JSON.parse(response))
      else data
      end
    end
  end
end
