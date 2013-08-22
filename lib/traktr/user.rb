module Traktr
  module User
    include HTTParty
    base_uri File.join(Traktr.base_uri, "user")

    def self.lastactivity(user = Traktr.username)
      response = self.get("/" + File.join("lastactivity.json", Traktr.api_key, user))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.list(slug, user = Traktr.username)
      response = self.get("/" + File.join("list.json", Traktr.api_key, user, slug))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.lists(user = Traktr.username)
      response = self.get("/" + File.join("lists.json", Traktr.api_key, user))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |item|
        Mash.new(item)
      end
    end

    def self.profile(user = Traktr.username)
      response = self.get("/" + File.join("profile.json", Traktr.api_key, user))
      raise ResponseError.new(response) if response.code != 200

      Mash.new(response.parsed_response)
    end

    def self.watching(user = Traktr.username)
      response = self.get("/" + File.join("watching.json", Traktr.api_key, user))
      raise ResponseError.new(response) if response.code != 200

      response.parsed_response.collect do |item|
        Mash.new(item)
      end
    end
  end
end

require 'traktr/user/library'
require 'traktr/user/network'
require 'traktr/user/progress'
require 'traktr/user/ratings'
require 'traktr/user/watchlist'
