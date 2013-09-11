module Traktr
  module User
    module Network
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'network')

      def self.followers(username = Traktr.username)
        response = self.get('/' + File.join('followers.json', Traktr.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def self.following(username = Traktr.username)
        response = self.get('/' + File.join('following.json', Traktr.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def self.friends(username = Traktr.username)
        response = self.get('/' + File.join('friends.json', Traktr.api_key, username))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
