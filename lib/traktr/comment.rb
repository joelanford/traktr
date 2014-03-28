module Traktr
  class Comment < Endpoint
    def episode( data )
      data.merge!(@auth.merge({ review: data[:comment].split(/\s+/).length > 200 }))
      parse_response self.class.post('/' + File.join('episode', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def movie( data )
      data.merge!(@auth.merge({ review: data[:comment].split(/\s+/).length > 200 }))
      parse_response self.class.post('/' + File.join('movie', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def show( data )
      data.merge!(@auth.merge({ review: data[:comment].split(/\s+/).length > 200 }))
      parse_response self.class.post('/' + File.join('show', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end
  end
end
