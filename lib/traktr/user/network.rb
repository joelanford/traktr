module Traktr
  class User
    class Network < Endpoint
      def followers(username = @client.username)
        parse_response self.class.get('/' + File.join('followers.json', @client.api_key, username))
      end

      def following(username = @client.username)
        parse_response self.class.get('/' + File.join('following.json', @client.api_key, username))
      end

      def friends(username = @client.username)
        parse_response self.class.get('/' + File.join('friends.json', @client.api_key, username))
      end
    end
  end
end
