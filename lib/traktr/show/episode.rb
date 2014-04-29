module Traktr
  class Show
    class Episode < Endpoint
      def comments(title, season, episode)
        parse_response self.class.get('/' + File.join('comments.json', @client.api_key, title, season.to_s, episode.to_s))
      end

      def stats(title, season, episode)
        parse_response self.class.get('/' + File.join('stats.json', @client.api_key, title, season.to_s, episode.to_s))
      end

      def summary(title, season, episode)
        parse_response self.class.get('/' + File.join('summary.json', @client.api_key, title, season.to_s, episode.to_s))
      end

      def watchingnow(title, season, episode)
        parse_response self.class.get('/' + File.join('watchingnow.json', @client.api_key, title, season.to_s, episode.to_s))
      end

      def library(show, episodes)
        data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
          episodes: episodes.map { |e| { season: e.season, episode: e.episode } }
        }
        parse_response self.class.post('/' + File.join('library', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      def unlibrary(show, episodes)
        data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
          episodes: episodes.map { |e| { season: e.season, episode: e.episode } }
        }
        parse_response self.class.post('/' + File.join('unlibrary', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      def seen(show, episodes)
        data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
          episodes: episodes.map { |e| { season: e.season, episode: e.episode } }
        }
        parse_response self.class.post('/' + File.join('seen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      def unseen(show, episodes)
        data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
          episodes: episodes.map { |e| { season: e.season, episode: e.episode } }
        }
        parse_response self.class.post('/' + File.join('unseen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      def watchlist(show, episodes)
        data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
          episodes: episodes.map { |e| { season: e.season, episode: e.episode } }
        }
        parse_response self.class.post('/' + File.join('watchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      def unwatchlist(show, episodes)
        data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
          episodes: episodes.map { |e| { season: e.season, episode: e.episode } }
        }
        parse_response self.class.post('/' + File.join('unwatchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end
    end
  end
end
