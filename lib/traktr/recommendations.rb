module Traktr
  class Recommendations
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'recommendations')

    def initialize(client)
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    def movies( data = {} )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('movies', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |show|
        Mash.new(show)
      end
    end

    def movies_dismiss( data )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('movies/dismiss', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def shows( data = {} )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('shows', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |show|
        Mash.new(show)
      end
    end

    def shows_dismiss( data )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('shows/dismiss', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end
