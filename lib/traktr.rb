require 'httparty'
require 'json'
require 'mash'

module Traktr
  include HTTParty
  base_uri "http://api.trakt.tv"
end


require 'traktr/client'
