module Traktr
  module Movies
    include HTTParty
    base_uri File.join(Traktr.base_uri, 'movies')

    ##
    ## movies GET methods
    ##
    def self.trending
      response = self.get('/' + File.join('trending.json', Traktr.api_key))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |movie|
        Mash.new(movie)
      end
    end

    def self.updated(timestamp)
      response = self.get('/' + File.join('updated.json', Traktr.api_key, timestamp.to_i.to_s))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

  end
end
