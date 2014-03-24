module Traktr
  class User
    class Progress
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'progress')

      def initialize(client)
        @client = client
        @auth = { :username => @client.username, :password => @client.password }
      end
      
      def collected(username = @client.username, title = :all, sort = :title, extended = :min)
        response = self.class.get('/' + File.join('collected.json', @client.api_key, username, title.to_s, sort.to_s, extended.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def watched(username = @client.username, title = :all, sort = :title, extended = :min)
        response = self.class.get('/' + File.join('watched.json', @client.api_key, username, title.to_s, sort.to_s, extended.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
