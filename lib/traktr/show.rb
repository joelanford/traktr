module Traktr
  class Show < Endpoint
    def comments(title, type = :all)
      type = [:all, :shouts, :reviews].include?(type) ? type.to_s : ""
      parse_response self.class.get("/" + File.join("comments.json", @client.api_key, title, type))

    end

    def related(title, hidewatched = nil)
      hidewatched = hidewatched == false || hidewatched == nil ? "" : "hidewatched"
      parse_response self.class.get("/" + File.join("related.json", @client.api_key, title, hidewatched.to_s), :basic_auth => @auth)
    end

    def season(title = nil, season = nil)
      if title && season
        parse_response self.class.get("/" + File.join("season.json", @client.api_key, title, season.to_s), :basic_auth => @auth)
      elsif !title && !season
        @season ||= Traktr::Show::Season.new(@client)
      else
        raise ArgumentError.new("wrong number of arguments")
      end
    end

    def seasons(title)
      parse_response self.class.get("/" + File.join("seasons.json", @client.api_key, title))
    end

    def stats(title)
      parse_response self.class.get('/' + File.join('stats.json', @client.api_key, title))
    end

    def summary(title, extended = nil)
      extended = [:normal, :full].include?(extended) ? extended.to_s : ""
      parse_response self.class.get("/" + File.join("summary.json", @client.api_key, title, extended), :basic_auth => @auth)
    end

    def summaries(titles, extended = nil)
      titles   = titles.join(",") if titles.class == Array
      extended = [:normal, :full].include?(extended) ? extended.to_s : ""
      parse_response self.class.get("/" + File.join("summaries.json", @client.api_key, titles, extended))
    end

    def watchingnow(title)
      parse_response self.class.get("/" + File.join("watchingnow.json", @client.api_key, title), :basic_auth => @auth)
    end

    def library(show)
      data = @auth.merge(show)
      parse_response self.class.post("/" + File.join("library", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def unlibrary(show)
      data = @auth.merge(show)
      parse_response self.class.post("/" + File.join("unlibrary", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def watchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = @auth.merge({ shows: shows })
      parse_response self.class.post("/" + File.join("watchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def unwatchlist(shows)
      shows = [ shows ] if shows.class != Array
      data = @auth.merge({ shows: shows })
      parse_response self.class.post("/" + File.join("unwatchlist", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def seen(show)
      data = @auth.merge(show)
      parse_response self.class.post("/" + File.join("seen", @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
    end

    def episode
      @episode ||= Traktr::Show::Episode.new(@client)
    end
  end
end
