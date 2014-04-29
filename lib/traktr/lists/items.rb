module Traktr
  class Lists
    class Items < Endpoint
      def add(slug, items)
        data = @auth.merge(slug: slug, items: items.class == Array ? items : [items])
        parse_response self.class.post('/' + File.join('add', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end

      def delete(slug, items)
        data = @auth.merge(slug: slug, items: items.class == Array ? items : [items])
        parse_response self.class.post('/' + File.join('delete', @client.api_key), body: data.to_json, headers: { 'Content-Type' => 'application/json' })
      end
    end
  end
end
