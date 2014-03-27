module Traktr
  class Network
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'network')

    def initialize(client)
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    def approve( user, follow_back = false )
      data = @auth.merge({:user => user, :follow_back => follow_back})
      response = self.class.post('/' + File.join('approve', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def deny( user )
      data = @auth.merge({:user => user})
      response = self.class.post('/' + File.join('deny', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def follow( user )
      data = @auth.merge({:user => user})
      response = self.class.post('/' + File.join('follow', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def requests
      data = @auth
      response = self.class.post('/' + File.join('requests', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def unfollow( user )
      data = @auth.merge({:user => user})
      response = self.class.post('/' + File.join('unfollow', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end