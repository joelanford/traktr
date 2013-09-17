require 'httparty'
require 'mash'
require 'json'
require 'uri'

module Traktr
  include HTTParty
  base_uri "http://api.trakt.tv"
end

require 'traktr/authentication'
require 'traktr/version'

require 'traktr/account'
require 'traktr/movie'
require 'traktr/movies'
require 'traktr/search'
require 'traktr/show'
require 'traktr/shows'
require 'traktr/user'
