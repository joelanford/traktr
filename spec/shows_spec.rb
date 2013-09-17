require 'spec_helper'

describe Traktr::Shows do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#trending' do
        shows = Traktr::Shows.trending
        expect(shows.size).to be > 0
      end

      it '#updated' do
        shows = Traktr::Shows.updated(Time.now - 3600 * 24)
        expect(shows.size).to be > 0
      end
    end

    context 'without valid api_key' do
      it '#trending' do
        expect { Traktr::Shows.trending }.to raise_error(Traktr::ResponseError)
      end

      it '#updated' do
        expect { Traktr::Shows.updated(Time.now - 3600 * 24) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end