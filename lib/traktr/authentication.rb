require 'digest/sha1'

module Traktr
  class << self
    def api_key
      @api_key ||= ""
    end

    def api_key=(api_key)
      @api_key = api_key
    end

    def username
      @username ||= ""
    end

    def username=(username)
      @username = username
    end

    def password
      @password ||= ""
    end

    def password=(password)
      @password = password == '' ? '' : Digest::SHA1.hexdigest(password)
    end
  end
end