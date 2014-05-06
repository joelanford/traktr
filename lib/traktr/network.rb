module Traktr
  class Network < Endpoint
    def approve(user, follow_back = false)
      data = @auth.merge(user: user, follow_back: follow_back)
      parse_response self.class.post(
        '/' + File.join('approve', @client.api_key),
        body: data.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def deny(user)
      data = @auth.merge(user: user)
      parse_response self.class.post(
        '/' + File.join('deny', @client.api_key),
        body: data.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def follow(user)
      data = @auth.merge(user: user)
      parse_response self.class.post(
        '/' + File.join('follow', @client.api_key),
        body: data.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def requests
      parse_response self.class.post(
        '/' + File.join('requests', @client.api_key),
        body: @auth.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def unfollow(user)
      data = @auth.merge(user: user)
      parse_response self.class.post(
        '/' + File.join('unfollow', @client.api_key),
        body: data.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end
  end
end
