module Traktr
  class Show
    class Episode
      include HTTParty
      base_uri File.join(Traktr::Show.base_uri, "episode")
      
      def initialize(client)
        @client = client
      end

      ##
      ## show-episode GET methods
      ##
      def comments(title, season, episode)
        response = self.class.get("/" + File.join("comments.json", @client.api_key, title, season.to_s, episode.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |comment|
          Mash.new(comment)
        end
      end

      def summary(title, season, episode)
        response = self.class.get("/" + File.join("summary.json", @client.api_key, title, season.to_s, episode.to_s))
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def watchingnow(title, season, episode)
        response = self.class.get("/" + File.join("watchingnow.json", @client.api_key, title, season.to_s, episode.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |user|
          Mash.new(user)
        end
      end


      ##
      ## show-episode POST methods
      ##
      def library(show, episodes)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.class.post("/" + File.join("library", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def unlibrary(show, episodes)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.class.post("/" + File.join("unlibrary", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def seen(show, episodes)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.class.post("/" + File.join("seen", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def unseen(show, episodes)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.class.post("/" + File.join("unseen", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def watchlist(show, episodes)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.class.post("/" + File.join("watchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

      def unwatchlist(show, episodes)
        data = {
            username: @client.username, password: @client.password,
            title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
            episodes: episodes.collect{ |e| { season: e.season, episode: e.episode } }
        }
        response = self.class.post("/" + File.join("unwatchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end
      def scrobble(show, season, episode)
        data = {
                username: @client.username, password: @client.password, title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id, season: show.season, episode: show.season, duration: show.duration, progress: show.progress, plugin_version: @client.plugin_version, media_center_version: @client.media_center_version, media_center_date: @client.media_center_date,
        }
        response = self.class.post("/" + File.join("scrobble", @client.api_key), body: data.to_json, headers: {'Content-Type' => 'application/json'})
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end

    end
  end
end
