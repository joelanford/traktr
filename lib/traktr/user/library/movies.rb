module Traktr
  class User
    class Library
      class Movies
        include HTTParty
        base_uri File.join(Traktr::User::Library.base_uri, 'movies')

        def all(username = @client.username, extended = :min)
          response = self.class.get('/' + File.join('all.json', @client.api_key, username, extended.to_s))
          raise ResponseError.new(response) if response.code != 200

          response.parsed_response.collect do |item|
            Mash.new(item)
          end
        end

        def collection(username = @client.username, extended = :min)
          response = self.class.get('/' + File.join('collection.json', @client.api_key, username, extended.to_s))
          raise ResponseError.new(response) if response.code != 200

          response.parsed_response.collect do |item|
            Mash.new(item)
          end
        end

        def watched(username = @client.username, extended = :min)
          response = self.class.get('/' + File.join('watched.json', @client.api_key, username, extended.to_s))
          raise ResponseError.new(response) if response.code != 200

          response.parsed_response.collect do |item|
            Mash.new(item)
          end
        end
      end
    end
  end
end
