module Traktr
  class User < Endpoint
    def lastactivity(user = @client.username)
      parse_response self.class.get('/' + File.join('lastactivity.json', @client.api_key, user), basic_auth: @auth)
    end

    def list(slug, user = @client.username)
      parse_response self.class.get('/' + File.join('list.json', @client.api_key, user, slug), basic_auth: @auth)
    end

    def lists(user = @client.username)
      parse_response self.class.get('/' + File.join('lists.json', @client.api_key, user), basic_auth: @auth)
    end

    def profile(user = @client.username)
      parse_response self.class.get('/' + File.join('profile.json', @client.api_key, user), basic_auth: @auth)
    end

    def watching(user = @client.username)
      #
      # TODO : When the user is protected or not currently watching anything, this
      #        returns an empty array. However, Trakt's documentation makes it seem
      #        like an empty object will be returned
      #
      parse_response self.class.get('/' + File.join('watching.json', @client.api_key, user), basic_auth: @auth)
    end

    def calendar
      @calendar ||= Traktr::User::Calendar.new(@client)
    end

    def library
      @library ||= Traktr::User::Library.new(@client)
    end

    def network
      @network ||= Traktr::User::Network.new(@client)
    end

    def progress
      @progress ||= Traktr::User::Progress.new(@client)
    end

    def ratings
      @ratings ||= Traktr::User::Ratings.new(@client)
    end

    def watchlist
      @watchlist ||= Traktr::User::Watchlist.new(@client)
    end
  end
end
