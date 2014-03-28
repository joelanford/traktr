module Traktr
  class Account < Endpoint
    def settings
      response = self.class.post("/" + File.join("settings", @client.api_key), body: @auth.to_json, headers: { 'Content-Type' => 'application/json'})
      parse_response(response)
    end

    def test
      response = self.class.post("/" + File.join("test", @client.api_key), body: @auth.to_json, headers: { 'Content-Type' => 'application/json'})
      parse_response(response)
    end
  end
end
