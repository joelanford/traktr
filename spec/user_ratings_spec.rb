require 'spec_helper'

describe Traktr::User::Ratings do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#episodes' do
        expect(@trakt.user.ratings.episodes('traktr').size).to be >= 0
      end

      it '#movies' do
        expect(@trakt.user.ratings.movies('traktr').size).to be >= 0
      end

      it '#shows' do
        expect(@trakt.user.ratings.shows('traktr').size).to be >= 0
      end
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#episodes' do
        expect(@trakt.user.ratings.episodes.size).to be >= 0
      end

      it '#movies' do
        expect(@trakt.user.ratings.movies.size).to be >= 0
      end

      it '#shows' do
        expect(@trakt.user.ratings.shows.size).to be >= 0
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#episodes' do
        expect { @trakt.user.ratings.episodes('traktr').size }.to raise_error(Traktr::ResponseError)
      end

      it '#movies' do
        expect { @trakt.user.ratings.movies('traktr').size }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.user.ratings.shows('traktr').size }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
