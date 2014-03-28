module Traktr
  class Shows < Endpoint
    def trending
      parse_response self.class.get('/' + File.join('trending.json', @client.api_key), :basic_auth => @auth)
    end

    def updated(timestamp)
      timestamp = timestamp.class == Time ? timestamp.to_i.to_s : timestamp.to_s
      parse_response self.class.get('/' + File.join('updated.json', @client.api_key, timestamp))
    end
  end
end
