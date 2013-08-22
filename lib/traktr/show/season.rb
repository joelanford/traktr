module Traktr
  module Show
    module Season
      include HTTParty
      base_uri File.join(Traktr::Show.base_uri, "season")

      ##
      ## show-season POST methods
      ##
      def self.library(show, season)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            season: season
        }
        response = self.post("/" + File.join("library", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def self.seen(show, season)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            season: season
        }
        response = self.post("/" + File.join("seen", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

    end
  end
end
