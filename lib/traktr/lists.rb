module Traktr
  class Lists
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'lists')

    def initialize(client)
      @client = client
      @auth = { username: @client.username, password: @client.password }
    end

    def add( data )
      data.merge!(@auth)
      response = self.class.post('/' + File.join('add', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def items
      @items ||= Traktr::Lists::Items.new(@client)
    end

    def delete( slug )
      data = @auth.merge({"slug" => slug})
      response = self.class.post('/' + File.join('delete', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def update( slug, data )
      data.merge!(@auth.merge({"slug" => slug}))
      response = self.class.post('/' + File.join('update', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end