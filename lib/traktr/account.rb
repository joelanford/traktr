module Traktr
  class Account
    include HTTParty
    base_uri File.join(Traktr.base_uri, "account")

    def initialize(client)
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    def settings
      data = @auth
      response = self.class.post("/" + File.join("settings", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def test
      data = @auth
      response = self.class.post("/" + File.join("test", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end
