module Traktr
  class Movie < Endpoint
    def comments(title, type = :all)
      type = [:all, :shouts, :reviews].include?(type) ? type.to_s : ""
      parse_response self.class.get('/' + File.join('comments.json', @client.api_key, title, type))
    end

    def related(title, hidewatched = nil)
      hidewatched = hidewatched == false || hidewatched == nil ? "" : "hidewatched"
      parse_response self.class.get('/' + File.join('related.json', @client.api_key, title, hidewatched), :basic_auth => @auth)
    end

    def stats(title)
      parse_response self.class.get('/' + File.join('stats.json', @client.api_key, title))
    end

    def summary(title, extended = nil)
      extended = [:normal, :full].include?(extended) ? extended.to_s : ""
      parse_response self.class.get('/' + File.join('summary.json', @client.api_key, title.to_s, extended), :basic_auth => @auth)
    end

    def summaries(titles, extended = nil)
      titles   = titles.join(",") if titles.class == Array
      extended = [:normal, :full].include?(extended) ? extended.to_s : ""
      parse_response self.class.get('/' + File.join('summaries.json', @client.api_key, titles, extended))
    end

    def watchingnow(title)
      parse_response self.class.get('/' + File.join('watchingnow.json', @client.api_key, title), :basic_auth => @auth)
    end

    def library(movies)
      movies = [ movies ] if movies.class != Array
      data = @auth.merge({ :movies => movies })
      parse_response self.class.post('/' + File.join('library', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def unlibrary(movies)
      movies = [ movies ] if movies.class != Array
      data = @auth.merge({ :movies => movies })
      parse_response self.class.post('/' + File.join('unlibrary', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def watchlist(movies)
      movies = [ movies ] if movies.class != Array
      data = @auth.merge({ :movies => movies })
      parse_response self.class.post('/' + File.join('watchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def unwatchlist(movies)
      movies = [ movies ] if movies.class != Array
      data = @auth.merge({ :movies => movies })
      parse_response self.class.post('/' + File.join('unwatchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def seen(movies)
      movies = [ movies ] if movies.class != Array
      data = @auth.merge({ :movies => movies })
      parse_response self.class.post('/' + File.join('seen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def unseen(movies)
      movies = [ movies ] if movies.class != Array
      data = @auth.merge({ :movies => movies })
      parse_response self.class.post('/' + File.join('unseen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def watching(movie, progress, media_center_version, media_center_date)
      data = {
        username: @client.username, password: @client.password, title: movie.title, year: movie.year, imdb_id: movie.imdb_id, duration: movie.duration, progress: progress, plugin_version: Traktr::VERSION, media_center_version: media_center_version, media_center_date: media_center_date,
      }
      response = self.class.post("/" + File.join("watching", @client.api_key), body: data.to_json, headers: {'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
    
    def scrobble(movie, progress, media_center_version, media_center_date)
      data = {
        username: @client.username, password: @client.password, title: movie.title, year: movie.year, imdb_id: movie.imdb_id, duration: movie.duration, progress: progress, plugin_version: Traktr::VERSION, media_center_version: media_center_version, media_center_date: media_center_date,
      }
      response = self.class.post("/" + File.join("scrobble", @client.api_key), body: data.to_json, headers: {'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def checkin(movie, app_version, app_date)
      data = {
        username: @client.username, password: @client.password, title: movie.title, year: movie.year, app_version: app_version, app_date: app_date,
      }
      response = self.class.post("/" + File.join("checkin", @client.api_key), body: data.to_json, headers: {'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def cancelwatching
      data = {
        username: @client.username, password: @client.password,
      }
      response = self.class.post("/" + File.join("cancelwatching", @client.api_key), body: data.to_json, headers: {'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def cancelcheckin
      data = {
        username: @client.username, password: @client.password,
      }
      response = self.class.post("/" + File.join("cancelcheckin", @client.api_key), body: data.to_json, headers: {'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end
