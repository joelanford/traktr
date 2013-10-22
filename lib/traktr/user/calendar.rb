module Traktr
  module User
    module Calendar
      include HTTParty
      base_uri File.join(Traktr::User.base_uri, 'calendar')

      def shows(username = @client.username, date = Date.today, days = 7)
        date = date.strftime('%Y%m%d') if date.class == Date
        response = self.class.get('/' + File.join('shows.json', @client.api_key, username, date, days.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |item|
          Mash.new(item)
        end
      end
    end
  end
end
