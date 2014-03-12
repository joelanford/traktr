require 'spec_helper'

describe Traktr::Genres do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#movies' do
        expect( @trakt.genres.movies ).to be
      end

      it '#shows' do
        expect( @trakt.genres.shows ).to be
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#movies' do
        expect { @trakt.genres.movies }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.genres.shows }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end