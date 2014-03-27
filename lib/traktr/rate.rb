module Traktr
  class Rate
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'rate')

    def initialize(client)
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    def episode( data )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('episode', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def episodes( data )
      data = @auth.merge( :episodes => data )
      response = self.class.post('/' + File.join('episodes', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def movie( data )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('movie', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def movies( data )
      data = @auth.merge( :movies => data )
      response = self.class.post('/' + File.join('movies', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def show( data )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('show', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def shows( data )
      data = @auth.merge( :shows => data )
      response = self.class.post('/' + File.join('shows', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end