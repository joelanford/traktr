module Traktr
  class Comment
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'comment')

    def initialize(client)
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    ##
    ## comment POST methods
    ##
    def episode( data )
      data.merge!(@auth.merge({ review: data[:comment].split(/\s+/).length > 200 }))
      response = self.class.post('/' + File.join('episode', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def movie( data )
      data.merge!(@auth.merge({ review: data[:comment].split(/\s+/).length > 200 }))
      response = self.class.post('/' + File.join('movie', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def show( data )
      data.merge!(@auth.merge({ review: data[:comment].split(/\s+/).length > 200 }))
      response = self.class.post('/' + File.join('show', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end