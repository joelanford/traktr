module Traktr
  class Calendar
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'calendar')

    def initialize(client)
      @client = client
      @auth = { :username => @client.username, :password => @client.password }
    end

    ##
    ## calendar GET methods
    ##
    def premieres(date = Date.today.strftime("%Y%m%d"), days = 7)
      date = date.class == Date ? date.strftime("%Y%m%d") : date
      response = self.class.get('/' + File.join('premieres.json', @client.api_key, date.to_s, days.to_s), :basic_auth => @auth)
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def shows(date = Date.today.strftime("%Y%m%d"), days = 7)
      date = date.class == Date ? date.strftime("%Y%m%d") : date
      response = self.class.get('/' + File.join('shows.json', @client.api_key, date.to_s, days.to_s), :basic_auth => @auth)
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

  end
end
