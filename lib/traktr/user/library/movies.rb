module Traktr
  module User
    module Library
      module Movies
        include HTTParty
        base_uri File.join(Traktr::User::Library.base_uri, 'movies')

        def self.all(username = Traktr.username, extended = :min)
          response = self.get('/' + File.join('all.json', Traktr.api_key, username, extended.to_s))
          raise ResponseError.new(response) if response.code != 200

          response.parsed_response.collect do |item|
            Mash.new(item)
          end
        end

        def self.collection(username = Traktr.username, extended = :min)
          response = self.get('/' + File.join('collection.json', Traktr.api_key, username, extended.to_s))
          raise ResponseError.new(response) if response.code != 200

          response.parsed_response.collect do |item|
            Mash.new(item)
          end
        end

        def self.watched(username = Traktr.username, extended = :min)
          response = self.get('/' + File.join('watched.json', Traktr.api_key, username, extended.to_s))
          raise ResponseError.new(response) if response.code != 200

          response.parsed_response.collect do |item|
            Mash.new(item)
          end
        end
      end
    end
  end
end
