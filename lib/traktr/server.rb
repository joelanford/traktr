module Traktr
  class Server < Endpoint
    def time
      parse_response self.class.get(
        '/' + File.join('time.json', @client.api_key)
      )
    end
  end
end
