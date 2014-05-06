module Traktr
  class Movies < Endpoint
    def trending
      parse_response self.class.get(
        '/' + File.join('trending.json', @client.api_key)
      )
    end

    def updated(timestamp)
      timestamp = timestamp.class == Time ? timestamp.to_i : timestamp
      parse_response self.class.get(
        '/' + File.join('updated.json', @client.api_key, timestamp.to_s)
      )
    end
  end
end
