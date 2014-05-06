module Traktr
  class Lists < Endpoint
    def add(data)
      data.merge!(@auth)
      parse_response self.class.post(
        '/' + File.join('add', @client.api_key),
        body: data.to_json, headers: { 'Content-Type' => 'application/json' }
      )
    end

    def delete(slug)
      data = @auth.merge(slug: slug)
      parse_response self.class.post(
        '/' + File.join('delete', @client.api_key),
        body: data.to_json, headers: { 'Content-Type' => 'application/json' }
      )
    end

    def update(slug, data)
      data.merge!(@auth.merge(slug: slug))
      parse_response self.class.post(
        '/' + File.join('update', @client.api_key),
        body: data.to_json, headers: { 'Content-Type' => 'application/json' }
      )
    end

    def items
      @items ||= Traktr::Lists::Items.new(@client)
    end
  end
end
