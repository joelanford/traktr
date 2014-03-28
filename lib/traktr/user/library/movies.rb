module Traktr
  class User
    class Library
      class Movies < Endpoint
        def all(username = @client.username, extended = :min)
          parse_response self.class.get('/' + File.join('all.json', @client.api_key, username, extended.to_s))
        end

        def collection(username = @client.username, extended = :min)
          parse_response self.class.get('/' + File.join('collection.json', @client.api_key, username, extended.to_s))
        end

        def watched(username = @client.username, extended = :min)
          parse_response self.class.get('/' + File.join('watched.json', @client.api_key, username, extended.to_s))
        end
      end
    end
  end
end
