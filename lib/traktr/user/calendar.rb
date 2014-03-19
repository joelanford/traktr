module Traktr
  class User
    class Calendar
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'calendar')

      def initialize(client)
        @client = client
        @auth = { :username => @client.username, :password => @client.password }
      end

      def shows(username = @client.username, date = Date.today, days = 7)
        date = date.class == Date ? date.strftime("%Y%m%d") : date.to_s

        response = self.class.get('/' + File.join('shows.json', @client.api_key, username, date, days.to_s), :basic_auth => @auth)
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
