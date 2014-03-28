require 'digest/sha1'

require 'traktr/endpoint'

require 'traktr/account'
require 'traktr/activity'
require 'traktr/activity/user'
require 'traktr/calendar'
require 'traktr/comment'
require 'traktr/genres'
require 'traktr/lists'
require 'traktr/lists/items'
require 'traktr/movie'
require 'traktr/movies'
require 'traktr/network'
require 'traktr/rate'
require 'traktr/recommendations'
require 'traktr/search'
require 'traktr/server'
require 'traktr/show'
require 'traktr/show/episode'
require 'traktr/show/season'
require 'traktr/shows'
require 'traktr/user'
require 'traktr/user/calendar'
require 'traktr/user/library'
require 'traktr/user/library/movies'
require 'traktr/user/library/shows'
require 'traktr/user/network'
require 'traktr/user/progress'
require 'traktr/user/ratings'
require 'traktr/user/watchlist'
require 'traktr/version'


module Traktr
  class Client
    attr_reader :api_key, :username, :password

    def initialize(api_key, username = nil, password = nil, sha1 = false)
      @api_key = api_key || ""
      @username = username || ""
      @password = password ? (sha1 ? password : Digest::SHA1.hexdigest(password)) : ""
    end

    def account
      @account ||= Traktr::Account.new(self)
    end

    def activity
      @activity ||= Traktr::Activity.new(self)
    end

    def calendar
      @calendar ||= Traktr::Calendar.new(self)
    end

    def comment
      @comment ||= Traktr::Comment.new(self)
    end

    def genres
      @genres ||= Traktr::Genres.new(self)
    end

    def lists
      @lists ||= Traktr::Lists.new(self)
    end

    def network
      @network ||= Traktr::Network.new(self)
    end

    def movie
      @movie ||= Traktr::Movie.new(self)
    end

    def movies
      @movies ||= Traktr::Movies.new(self)
    end

    def rate
      @rate ||= Traktr::Rate.new(self)
    end

    def recommendations
      @recommendations ||= Traktr::Recommendations.new(self)
    end

    def search
      @search ||= Traktr::Search.new(self)
    end

    def server
      @server ||= Traktr::Server.new(self)
    end

    def show
      @show ||= Traktr::Show.new(self)
    end

    def shows
      @shows ||= Traktr::Shows.new(self)
    end

    def user
      @user ||= Traktr::User.new(self)
    end

    def version
      @version ||= Traktr::Version.new(self)
    end
  end
end
