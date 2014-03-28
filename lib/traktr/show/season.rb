module Traktr
  class Show
    class Season < Endpoint
      def library(show, season)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            season: season
        }
        parse_response self.class.post("/" + File.join("library", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      end

      def seen(show, season)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            season: season
        }
        parse_response self.class.post("/" + File.join("seen", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      end
    end
  end
end
