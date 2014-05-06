module Traktr
  class Rate < Endpoint
    def episode(data)
      parse_response self.class.post(
        '/' + File.join('episode', @client.api_key),
        body: data.merge(@auth).to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def episodes(data)
      data = @auth.merge(episodes: data)
      parse_response self.class.post(
        '/' + File.join('episodes', @client.api_key),
        body: data.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def movie(data)
      parse_response self.class.post(
        '/' + File.join('movie', @client.api_key),
        body: data.merge(@auth).to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def movies(data)
      data = @auth.merge(movies: data)
      parse_response self.class.post(
        '/' + File.join('movies', @client.api_key),
        body: data.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def show(data)
      parse_response self.class.post(
        '/' + File.join('show', @client.api_key),
        body: data.merge(@auth).to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end

    def shows(data)
      data = @auth.merge(shows: data)
      parse_response self.class.post(
        '/' + File.join('shows', @client.api_key),
        body: data.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
    end
  end
end
