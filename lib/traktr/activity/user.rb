module Traktr
  class Activity
    class User < Endpoint
      def episodes(username, title, season, episode, actions = :all,
                   start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(',') : actions.to_s
        parse_response self.class.get('/' + File.join(
          'episodes.json', @client.api_key, username, title, season.to_s,
          episode.to_s, actions, start_ts.to_s, end_ts.to_s
        ))
      end

      def movies(username, title, actions = :all,
                 start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(',') : actions.to_s
        parse_response self.class.get('/' + File.join(
          'movies.json', @client.api_key, username, title, actions,
          start_ts.to_s, end_ts.to_s
        ))
      end

      def seasons(username, title, season, actions = :all,
                  start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(',') : actions.to_s
        parse_response self.class.get('/' + File.join(
          'seasons.json', @client.api_key, username, title, season.to_s,
          actions, start_ts.to_s, end_ts.to_s
        ))
      end

      def shows(username, title, actions = :all,
                start_ts = 0, end_ts = Time.now.to_i)
        actions = actions.class == Array ? actions.join(',') : actions.to_s
        parse_response self.class.get('/' + File.join(
          'shows.json', @client.api_key, username, title, actions,
          start_ts.to_s, end_ts.to_s
        ))
      end
    end
  end
end
