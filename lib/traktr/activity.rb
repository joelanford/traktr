module Traktr
  class Activity < Endpoint
    def community(types = :all, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      types   =   types.class == Array ?   types.join(',') :   types.to_s
      actions = actions.class == Array ? actions.join(',') : actions.to_s
      parse_response self.class.get('/' + File.join('community.json', @client.api_key, types, actions, start_ts.to_s, end_ts.to_s))
    end

    def episodes(title, season, episode, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      actions = actions.class == Array ? actions.join(',') : actions.to_s
      parse_response self.class.get('/' + File.join('episodes.json', @client.api_key, title, season.to_s, episode.to_s, actions, start_ts.to_s, end_ts.to_s))
    end

    def movies(title, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      actions = actions.class == Array ? actions.join(',') : actions.to_s
      parse_response self.class.get('/' + File.join('movies.json', @client.api_key, title, actions, start_ts.to_s, end_ts.to_s))
    end

    def seasons(title, season, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      actions = actions.class == Array ? actions.join(',') : actions.to_s
      parse_response self.class.get('/' + File.join('seasons.json', @client.api_key, title, season.to_s, actions, start_ts.to_s, end_ts.to_s))
    end

    def shows(title, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      actions = actions.class == Array ? actions.join(',') : actions.to_s
      parse_response self.class.get('/' + File.join('shows.json', @client.api_key, title, actions, start_ts.to_s, end_ts.to_s))
    end

    def user(username = nil, types = :all, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      if username
        types   =   types.class == Array ?   types.join(',') :   types.to_s
        actions = actions.class == Array ? actions.join(',') : actions.to_s
        parse_response self.class.get('/' + File.join('user.json', @client.api_key, username, types, actions, start_ts.to_s, end_ts.to_s))
      else
        @user ||= Traktr::Activity::User.new(@client)
      end
    end

    def friends(types = :all, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
      types   =   types.class == Array ?   types.join(',') :   types.to_s
      actions = actions.class == Array ? actions.join(',') : actions.to_s
      parse_response self.class.post('/' + File.join('friends.json', @client.api_key, types, actions, start_ts.to_s, end_ts.to_s), body: @auth.to_json, headers: { 'Content-Type' => 'application/json' })
    end
  end
end
