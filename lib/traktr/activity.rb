module Traktr
  class Activity
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'activity')

    def initialize(client)
      @client = client
    end

    ##
    ## activity GET methods
    ##
    def community(types = :all, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      response = self.class.get('/' + File.join('community.json', @client.api_key, types.to_s, actions.to_s, start_ts.to_s, end_ts.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def episodes(title, season, episode, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      response = self.class.get('/' + File.join('episodes.json', @client.api_key, title, season.to_s, episode.to_s, actions.to_s, start_ts.to_s, end_ts.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end 

    def movies(title, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      response = self.class.get('/' + File.join('movies.json', @client.api_key, title, actions.to_s, start_ts.to_s, end_ts.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def seasons(title, season, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      response = self.class.get('/' + File.join('seasons.json', @client.api_key, title, season.to_s, actions.to_s, start_ts.to_s, end_ts.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def shows(title, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      response = self.class.get('/' + File.join('shows.json', @client.api_key, title, actions.to_s, start_ts.to_s, end_ts.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def user(username = nil, types = :all, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      if username
        response = self.class.get('/' + File.join('user.json', @client.api_key, username, types.to_s, actions.to_s, start_ts.to_s, end_ts.to_s))
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      else
        @user ||= Traktr::Activity::User.new(@client)
      end
    end

    ##
    ## activity POST methods
    ##
    def friends(types = :all, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      data = { username: @client.username, password: @client.password }
      response = self.class.post('/' + File.join('friends.json', @client.api_key, types.to_s, actions.to_s, start_ts.to_s, end_ts.to_s), body: data.to_json, headers: { 'Content-Type' => 'application/json'})
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end   
  end
end
