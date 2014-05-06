module Traktr
  class Calendar < Endpoint
    def premieres(date = Date.today, days = 7)
      date = date.class == Date ? date.strftime('%Y%m%d') : date.to_s
      parse_response self.class.get(
        '/' + File.join('premieres.json', @client.api_key, date, days.to_s),
        basic_auth: @auth
      )
    end

    def shows(date = Date.today, days = 7)
      date = date.class == Date ? date.strftime('%Y%m%d') : date.to_s
      parse_response self.class.get(
        '/' + File.join('shows.json', @client.api_key, date, days.to_s),
        basic_auth: @auth
      )
    end
  end
end
