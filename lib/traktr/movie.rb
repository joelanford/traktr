module Traktr
  class Movie < Endpoint
    def comments(title, type = :all)
      type = [:all, :shouts, :reviews].include?(type) ? type.to_s : ''
      parse_response self.class.get('/' + File.join('comments.json', @client.api_key, title, type))
    end

    def related(title, hidewatched = nil)
      hidewatched = hidewatched == false || hidewatched.nil? ? '' : 'hidewatched'
      parse_response self.class.get('/' + File.join('related.json', @client.api_key, title, hidewatched), basic_auth: @auth)
    end

    def stats(title)
      parse_response self.class.get('/' + File.join('stats.json', @client.api_key, title))
    end

    def summary(title, extended = nil)
      extended = [:normal, :full].include?(extended) ? extended.to_s : ''
      parse_response self.class.get('/' + File.join('summary.json', @client.api_key, title.to_s, extended), basic_auth: @auth)
    end

    def summaries(titles, extended = nil)
      titles   = titles.join(',') if titles.class == Array
      extended = [:normal, :full].include?(extended) ? extended.to_s : ''
      parse_response self.class.get('/' + File.join('summaries.json', @client.api_key, titles, extended))
    end

    def watchingnow(title)
      parse_response self.class.get('/' + File.join('watchingnow.json', @client.api_key, title), basic_auth: @auth)
    end

    def library(movies)
      movies = [movies] if movies.class != Array
      data = @auth.merge(movies: movies)
      parse_response self.class.post('/' + File.join('library', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def unlibrary(movies)
      movies = [movies] if movies.class != Array
      data = @auth.merge(movies: movies)
      parse_response self.class.post('/' + File.join('unlibrary', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def watchlist(movies)
      movies = [movies] if movies.class != Array
      data = @auth.merge(movies: movies)
      parse_response self.class.post('/' + File.join('watchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def unwatchlist(movies)
      movies = [movies] if movies.class != Array
      data = @auth.merge(movies: movies)
      parse_response self.class.post('/' + File.join('unwatchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def seen(movies)
      movies = [movies] if movies.class != Array
      data = @auth.merge(movies: movies)
      parse_response self.class.post('/' + File.join('seen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
    end

    def unseen(movies)
      movies = [movies] if movies.class != Array
      data = @auth.merge(movies: movies)
      parse_response self.class.post('/' + File.join('unseen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
    end
  end
end
