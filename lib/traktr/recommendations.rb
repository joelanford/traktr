module Traktr
  class Recommendations < Endpoint
    def movies(data = {})
      parse_response self.class.post('/' + File.join('movies', @client.api_key), body: data.merge(@auth).to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def movies_dismiss(data)
      parse_response self.class.post('/' + File.join('movies/dismiss', @client.api_key), body: data.merge(@auth).to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def shows(data = {})
      parse_response self.class.post('/' + File.join('shows', @client.api_key), body: data.merge(@auth).to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def shows_dismiss(data)
      parse_response self.class.post('/' + File.join('shows/dismiss', @client.api_key), body: data.merge(@auth).to_json, headers: { 'Content-Type' => 'application/json' })
    end
  end
end
