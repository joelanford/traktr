module Traktr
  class Activity
  	class User
  	  include HTTParty
      base_uri File.join(Traktr::Activity.base_uri, "user")

      def initialize(client)
        @client = client
      end

      def episodes(username, title, season, episode, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(",") : actions.to_s

        response = self.class.get('/' + File.join('episodes.json', @client.api_key, username, title, season.to_s, episode.to_s, actions, start_ts.to_s, end_ts.to_s))
        raise ResponseError.new(response) if response.code != 200

        Mash.new(response.parsed_response)
      end 

      def movies(username, title, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(",") : actions.to_s

        response = self.class.get('/' + File.join('movies.json', @client.api_key, username, title, actions, start_ts.to_s, end_ts.to_s))
        raise ResponseError.new(response) if response.code != 200
       
        Mash.new(response.parsed_response)
      end

      def seasons(username, title, season, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(",") : actions.to_s

        response = self.class.get('/' + File.join('seasons.json', @client.api_key, username, title, season.to_s, actions, start_ts.to_s, end_ts.to_s))
        raise ResponseError.new(response) if response.code != 200
       
        Mash.new(response.parsed_response)
      end

      def shows(username, title, actions = :all, start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(",") : actions.to_s

        response = self.class.get('/' + File.join('shows.json', @client.api_key, username, title, actions, start_ts.to_s, end_ts.to_s))
        raise ResponseError.new(response) if response.code != 200
       
        Mash.new(response.parsed_response)
      end      
  	end
  end
end