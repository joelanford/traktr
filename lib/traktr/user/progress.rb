module Traktr
  class User
    class Progress < Endpoint
      def collected(username = @client.username, title = :all, sort = :title, extended = :min)
        parse_response self.class.get('/' + File.join('collected.json', @client.api_key, username, title.to_s, sort.to_s, extended.to_s))
      end

      def watched(username = @client.username, title = :all, sort = :title, extended = :min)
        parse_response self.class.get('/' + File.join('watched.json', @client.api_key, username, title.to_s, sort.to_s, extended.to_s))
      end
    end
  end
end
