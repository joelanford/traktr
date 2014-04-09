module Traktr
  class Account < Endpoint
    def create(username, password, email, sha1 = false)
      data = { :username => username, :password => sha1 ? password : Digest::SHA1.hexdigest(password), :email => email }
      response = self.class.post("/" + File.join("create", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      parse_response(response)
    end

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
