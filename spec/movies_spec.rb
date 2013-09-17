require 'spec_helper'

describe Traktr::Movies do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#trending' do
        movies = Traktr::Movies.trending
        expect(movies.size).to be > 0
      end

      it '#updated' do
        movies = Traktr::Movies.updated(Time.now - 3600 * 24)
        expect(movies.size).to be > 0
      end
    end

    context 'without valid api_key' do
      it '#trending' do
        expect { Traktr::Movies.trending }.to raise_error(Traktr::ResponseError)
      end

      it '#updated' do
        expect { Traktr::Movies.updated(Time.now - 3600 * 24) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end