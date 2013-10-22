require 'spec_helper'

describe Traktr::Shows do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#trending' do
        expect( @trakt.shows.trending.size ).to be > 0
      end

      it '#updated' do
        expect( @trakt.shows.updated(Time.now - 3600 * 24).size ).to be > 0
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#trending' do
        expect { @trakt.shows.trending }.to raise_error(Traktr::ResponseError)
      end

      it '#updated' do
        expect { @trakt.shows.updated(Time.now - 3600 * 24) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end