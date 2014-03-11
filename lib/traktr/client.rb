require 'digest/sha1'

require 'traktr/account'
require 'traktr/activity'
require 'traktr/activity/user'
require 'traktr/movie'
require 'traktr/movies'
require 'traktr/search'
require 'traktr/show'
require 'traktr/show/episode'
require 'traktr/show/season'
require 'traktr/shows'
require 'traktr/user'
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

    def movie
      @movie ||= Traktr::Movie.new(self)
    end

    def movies
      @movies ||= Traktr::Movies.new(self)
    end

    def search
      @search ||= Traktr::Search.new(self)
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