module Traktr
  class User
    class Network
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'network')

      def followers(username = @client.username)
        response = self.class.get('/' + File.join('followers.json', @client.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def following(username = @client.username)
        response = self.class.get('/' + File.join('following.json', @client.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def friends(username = @client.username)
        response = self.class.get('/' + File.join('friends.json', @client.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
