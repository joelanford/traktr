module Traktr
  class Movie
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'movie')

    def initialize(client)
      @client = client
    end

    ##
    ## movie GET methods
    ##
    def comments(title, type = :all)
      response = self.class.get('/' + File.join('comments.json', @client.api_key, title, type.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |comment|
        Mash.new(comment)
      end
    end

    def related(title, hidewatched = false)
      response = self.class.get('/' + File.join('related.json', @client.api_key, title, hidewatched.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def summary(title, extended = :min)
      response = self.class.get('/' + File.join('summary.json', @client.api_key, title.to_s, extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def summaries(titles, extended = :min)
      titles = [titles] if titles.class == String
      response = self.class.get('/' + File.join('summaries.json', @client.api_key, titles.join(','), extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def watchingnow(title)
      response = self.class.get('/' + File.join('watchingnow.json', @client.api_key, title))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |user|
        Mash.new(user)
      end
    end

    ##
    ## movie POST methods
    ##
    def library(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: @client.username, password: @client.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.class.post('/' + File.join('library', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def unlibrary(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: @client.username, password: @client.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.class.post('/' + File.join('unlibrary', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def watchlist(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: @client.username, password: @client.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.class.post('/' + File.join('watchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def unwatchlist(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: @client.username, password: @client.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.class.post('/' + File.join('unwatchlist', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def seen(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: @client.username, password: @client.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.class.post('/' + File.join('seen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def unseen(movies)
      movies = [ movies ] if movies.class != Array
      data = {
          username: @client.username, password: @client.password,
          movies: movies.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tmdb_id: s.tmdb_id }}
      }
      response = self.class.post('/' + File.join('unseen', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end
