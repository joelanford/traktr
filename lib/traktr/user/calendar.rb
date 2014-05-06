module Traktr
  class User
    class Calendar < Endpoint
      def shows(username = @client.username, date = Date.today, days = 7)
        date = date.class == Date ? date.strftime('%Y%m%d') : date.to_s
        parse_response self.class.get(
          '/' + File.join('shows.json', @client.api_key, username, date,
                          days.to_s),
          basic_auth: @auth
        )
      end
    end
  end
end
