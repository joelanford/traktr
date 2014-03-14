module Traktr
  class Show
    include HTTParty
    base_uri File.join(Traktr.base_uri, "show")

    def initialize(client)
      @client = client
      @auth = { :username => @client.username, :password => @client.password }
    end

    def episode
      @episode ||= Traktr::Show::Episode.new(@client)
    end

    ##
    ## show GET methods
    ##
    def comments(title, type = :all)
      type = [:all, :shouts, :reviews].include?(type) ? type.to_s : ""

      response = self.class.get("/" + File.join("comments.json", @client.api_key, title, type))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def related(title, hidewatched = nil)
      hidewatched = hidewatched == false || hidewatched == nil ? "" : "hidewatched"

      response = self.class.get("/" + File.join("related.json", @client.api_key, title, hidewatched.to_s), :basic_auth => @auth)
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def season(title = nil, season = nil)
      if title && season
        response = self.class.get("/" + File.join("season.json", @client.api_key, title, season.to_s), :basic_auth => @auth)
        raise ResponseError.new(response) if response.code != 200

        response.parsed_response.collect do |data|
          Mash.new(data)
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

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def stats(title)
      response = self.class.get('/' + File.join('stats.json', @client.api_key, title))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def summary(title, extended = nil)
      extended = [:normal, :full].include?(extended) ? extended.to_s : ""

      response = self.class.get("/" + File.join("summary.json", @client.api_key, title, extended), :basic_auth => @auth)
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def summaries(titles, extended = nil)
      titles   = titles.join(",") if titles.class == Array
      extended = [:normal, :full].include?(extended) ? extended.to_s : ""

      response = self.class.get("/" + File.join("summaries.json", @client.api_key, titles, extended))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    def watchingnow(title)
      response = self.class.get("/" + File.join("watchingnow.json", @client.api_key, title), :basic_auth => @auth)
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |data|
        Mash.new(data)
      end
    end

    ##
    ## show POST methods
    ##
    def library(show)
      data = @auth.merge(show)

      response = self.class.post("/" + File.join("library", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def unlibrary(show)
      data = @auth.merge(show)

      response = self.class.post("/" + File.join("unlibrary", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def watchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = @auth.merge({ shows: shows })

      response = self.class.post("/" + File.join("watchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(JSON.parse(response.parsed_response))
    end

    def unwatchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = @auth.merge({ shows: shows })

      response = self.class.post("/" + File.join("unwatchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def seen(show)
      data = @auth.merge(show)

      response = self.class.post("/" + File.join("seen", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end
  end
end
