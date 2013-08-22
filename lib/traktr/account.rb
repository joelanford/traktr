module Traktr
  module Account
    include HTTParty
    base_uri File.join(Traktr.base_uri, "account")

    def self.settings
      data = { username: Traktr.username, password: Traktr.password }
      response = self.post("/" + File.join("settings", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.test
      data = { username: Traktr.username, password: Traktr.password }
      response = self.post("/" + File.join("test", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

  end
end
