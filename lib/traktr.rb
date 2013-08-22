require 'httparty'
require 'mash'
require 'json'

module Traktr
  include HTTParty
  base_uri "http://api.trakt.tv"
end

require 'traktr/authentication'
require 'traktr/version'

require 'traktr/account'
require 'traktr/movie'
require 'traktr/show'
require 'traktr/user'
