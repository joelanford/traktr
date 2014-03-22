module Traktr
  class Lists
    class Items
      include HTTParty
      base_uri File.join(Traktr::Lists.base_uri, "items")

      def initialize(client)
        @client = client
        @auth = { username: @client.username, password: @client.password }
      end

      def add( slug, items )
        data = @auth.merge({"slug" => slug, "items" => items.class == Array ? items : [items]})
        response = self.class.post('/' + File.join('add', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(JSON.parse(response.parsed_response))
      end

      def delete( slug, items )
        data = @auth.merge({"slug" => slug, "items" => items.class == Array ? items : [items]})
        response = self.class.post('/' + File.join('delete', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end
    end
  end
end