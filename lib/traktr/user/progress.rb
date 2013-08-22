module Traktr
  module User
    module Progress
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'progress')

      def self.collected(username = Traktr.username, title = :all, sort = :title, extended = :min)
        response = self.get('/' + File.join('collected.json', Traktr.api_key, username, title.to_s, sort.to_s, extended.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end

      def self.watched(username = Traktr.username, title = :all, sort = :title, extended = :min)
        response = self.get('/' + File.join('watched.json', Traktr.api_key, username, title.to_s, sort.to_s, extended.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
