require 'spec_helper'

describe Traktr::Recommendations do
  context 'POST methods' do
    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#movies' do
        expect(@trakt.recommendations.movies.class).to eql(Array)
      end

      it '#shows' do
        expect(@trakt.recommendations.shows.class).to eql(Array)
      end

      it '#movies_dismiss' do
        expect(@trakt.recommendations.movies_dismiss(imdb_id: 'tt0435761').status).to eql('success')
      end

      it '#shows_dismiss' do
        expect(@trakt.recommendations.shows_dismiss(tvdb_id: '80348').status).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#movies' do
        expect { @trakt.recommendations.movies.class }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.recommendations.shows.class }.to raise_error(Traktr::ResponseError)
      end

      it '#movies_dismiss' do
        expect { @trakt.recommendations.movies_dismiss(imdb_id: 'tt0435761').status }.to raise_error(Traktr::ResponseError)
      end

      it '#shows_dismiss' do
        expect { @trakt.recommendations.shows_dismiss(tvdb_id: '80348').status }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#movies' do
        expect { @trakt.recommendations.movies.class }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.recommendations.shows.class }.to raise_error(Traktr::ResponseError)
      end

      it '#movies_dismiss' do
        expect { @trakt.recommendations.movies_dismiss(imdb_id: 'tt0435761').status }.to raise_error(Traktr::ResponseError)
      end

      it '#shows_dismiss' do
        expect { @trakt.recommendations.shows_dismiss(tvdb_id: '80348').status }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
