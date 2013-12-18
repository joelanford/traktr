module Traktr
  class Show
    include HTTParty
    base_uri File.join(Traktr.base_uri, "show")

    def initialize(client)
      @client = client
    end

    def episode
      @episode ||= Traktr::Show::Episode.new(@client)
    end

    def season
      

    end

    ##
    ## show GET methods
    ##
    def comments(title, type = :all)
      response = self.class.get("/" + File.join("comments.json", @client.api_key, title, type.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |comment|
        Mash.new(comment)
      end
    end

    def related(title, hidewatched = false)
      response = self.class.get("/" + File.join("related.json", @client.api_key, title, hidewatched.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def season(title = nil, season = nil)
      if title && season
        response = self.class.get("/" + File.join("season.json", @client.api_key, title, season.to_s))
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |episode|
          Mash.new(episode)
        end
      elsif !title && !season
        @season ||= Traktr::Show::Season.new(@client)
      else
        raise ArgumentError.new("wrong number of arguments")
      end
    end

    def seasons(title)
      response = self.class.get("/" + File.join("seasons.json", @client.api_key, title))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |season|
        Mash.new(season)
      end
    end

    def summary(title, extended = :min)
      response = self.class.get("/" + File.join("summary.json", @client.api_key, title, extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def summaries(titles, extended = :min)
      titles = [titles] if titles.class == String
      response = self.class.get("/" + File.join("summaries.json", @client.api_key, titles.join(","), extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def watchingnow(title)
      response = self.class.get("/" + File.join("watchingnow.json", @client.api_key, title))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |user|
        Mash.new(user)
      end
    end

    ##
    ## show POST methods
    ##
    def library(show)
      data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
      }
      response = self.class.post("/" + File.join("library", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def unlibrary(show)
      data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
      }
      response = self.class.post("/" + File.join("unlibrary", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def watchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = {
          username: @client.username, password: @client.password,
          shows: shows.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tvdb_id: s.tvdb_id }}
      }
      response = self.class.post("/" + File.join("watchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def unwatchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = {
          username: @client.username, password: @client.password,
          shows: shows.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tvdb_id: s.tvdb_id }}
      }
      response = self.class.post("/" + File.join("unwatchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def seen(show)
      data = {
          username: @client.username, password: @client.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
      }
      response = self.class.post("/" + File.join("seen", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

  end
end
