module Traktr
  module Show
    module Episode
      include HTTParty
      base_uri File.join(Traktr::Show.base_uri, "episode")

      ##
      ## show-episode GET methods
      ##
      def self.comments(title, season, episode)
        response = self.get("/" + File.join("comments.json", Traktr.api_key, title, season.to_s, episode.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |comment|
          Mash.new(comment)
        end
      end

      def self.summary(title, season, episode)
        response = self.get("/" + File.join("summary.json", Traktr.api_key, title, season.to_s, episode.to_s))
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def self.watchingnow(title, season, episode)
        response = self.get("/" + File.join("watchingnow.json", Traktr.api_key, title, season.to_s, episode.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |user|
          Mash.new(user)
        end
      end


      ##
      ## show-episode POST methods
      ##
      def self.library(show, episodes)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.post("/" + File.join("library", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def self.unlibrary(show, episodes)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.post("/" + File.join("unlibrary", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def self.seen(show, episodes)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.post("/" + File.join("seen", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def self.unseen(show, episodes)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.post("/" + File.join("unseen", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def self.watchlist(show, episodes)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.post("/" + File.join("watchlist", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def self.unwatchlist(show, episodes)
        data = {
            username: Traktr.username, password: Traktr.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.post("/" + File.join("unwatchlist", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end
    end
  end
end
