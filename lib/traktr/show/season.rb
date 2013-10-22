module Traktr
  class Show
    class Season
      include HTTParty
      base_uri File.join(Traktr::Show.base_uri, "season")

      def initialize(client)
        @client = client
      end
      
      ##
      ## show-season POST methods
      ##
      def library(show, season)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            season: season
        }
        response = self.class.post("/" + File.join("library", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def seen(show, season)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            season: season
        }
        response = self.class.post("/" + File.join("seen", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

    end
  end
end
