require 'httparty'
require 'json'
require 'mash'

module Traktr
  include HTTParty
  base_uri "https://api.trakt.tv"
end

require 'traktr/client'
