module Traktr
  module Show
    include HTTParty
    base_uri File.join(Traktr.base_uri, "show")

    ##
    ## show GET methods
    ##
    def self.comments(title, type = :all)
      response = self.get("/" + File.join("comments.json", Traktr.api_key, title, type.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |comment|
        Mash.new(comment)
      end
    end

    def self.related(title, hidewatched = false)
      response = self.get("/" + File.join("related.json", Traktr.api_key, title, hidewatched.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def self.season(title, season)
      response = self.get("/" + File.join("season.json", Traktr.api_key, title, season.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |episode|
        Mash.new(episode)
      end
    end

    def self.seasons(title)
      response = self.get("/" + File.join("seasons.json", Traktr.api_key, title))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |season|
        Mash.new(season)
      end
    end

    def self.summary(title, extended = :min)
      response = self.get("/" + File.join("summary.json", Traktr.api_key, title, extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.summaries(titles, extended = :min)
      titles = [titles] if titles.class == String
      response = self.get("/" + File.join("summaries.json", Traktr.api_key, titles.join(","), extended.to_s))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |summary|
        Mash.new(summary)
      end
    end

    def self.watchingnow(title)
      response = self.get("/" + File.join("watchingnow.json", Traktr.api_key, title))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |user|
        Mash.new(user)
      end
    end

    ##
    ## show POST methods
    ##
    def self.library(show)
      data = {
          username: Traktr.username, password: Traktr.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
      }
      response = self.post("/" + File.join("library", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.unlibrary(show)
      data = {
          username: Traktr.username, password: Traktr.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
      }
      response = self.post("/" + File.join("unlibrary", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.watchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          shows: shows.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tvdb_id: s.tvdb_id }}
      }
      response = self.post("/" + File.join("watchlist", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def self.unwatchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = {
          username: Traktr.username, password: Traktr.password,
          shows: shows.collect{ |s| { title: s.title, year: s.year, imdb_id: s.imdb_id, tvdb_id: s.tvdb_id }}
      }
      response = self.post("/" + File.join("unwatchlist", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.seen(show)
      data = {
          username: Traktr.username, password: Traktr.password,
          title: show.title, year: show.year, imdb_id: show.imdb_id, tvdb_id: show.tvdb_id,
      }
      response = self.post("/" + File.join("seen", Traktr.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end

require 'traktr/show/episode'
require 'traktr/show/season'
