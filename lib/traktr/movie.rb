module Traktr
  module Movie
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'movie')

    ##
    ## movie GET methods
    ##
    def self.comments(title, type = :all)
      response = self.get('/' + File.join('comments.json', Traktr.api_key, title, type.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |comment|
        Mash.new(comment)
      end
    end

    def self.related(title, hidewatched = false)
      response = self.get('/' + File.join('related.json', Traktr.api_key, title, hidewatched.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def self.summary(title, extended = :min)
      response = self.get('/' + File.join('summary.json', Traktr.api_key, title.to_s, extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.summaries(titles, extended = :min)
      titles = [titles] if titles.class == String
      response = self.get('/' + File.join('summaries.json', Traktr.api_key, titles.join(','), extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def self.watchingnow(title)
      response = self.get('/' + File.join('watchingnow.json', Traktr.api_key, title))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |user|
        Mash.new(user)
      end
    end

    ##
    ## movie POST methods
    ##
    def self.library(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.post('/' + File.join('library', Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def self.unlibrary(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.post('/' + File.join('unlibrary', Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.watchlist(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.post('/' + File.join('watchlist', Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def self.unwatchlist(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.post('/' + File.join('unwatchlist', Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.seen(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.post('/' + File.join('seen', Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def self.unseen(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.post('/' + File.join('unseen', Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end
