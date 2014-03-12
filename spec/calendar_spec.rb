require 'spec_helper'

describe Traktr::Calendar do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#premieres' do
        expect( @trakt.calendar.premieres.class ).to eql(Array)
      end

      it '#shows' do
        expect( @trakt.calendar.shows.class ).to eql(Array)
      end
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#premieres' do
        premieres = @trakt.calendar.premieres
        expect( premieres.class ).to eql(Array)
        premieres.each do |day|
          day.episodes.each do |episode|
            expect( episode.show.rating ).not_to eql(nil)
            expect( episode.show.rating_advanced ).not_to eql(nil)
            expect( episode.show.in_watchlist ).not_to eql(nil)

            expect( episode.episode.watched ).not_to eql(nil)
            expect( episode.episode.plays ).not_to eql(nil)
            expect( episode.episode.in_watchlist ).not_to eql(nil)
            expect( episode.episode.in_collection ).not_to eql(nil)
            expect( episode.episode.rating ).not_to eql(nil)
            expect( episode.episode.rating_advanced ).not_to eql(nil)
          end
        end

      end

      it '#shows' do
        shows = @trakt.calendar.shows
        expect( shows.class ).to eql(Array)
        shows.each do |day|
          day.episodes.each do |episode|
            expect( episode.show.rating ).not_to eql(nil)
            expect( episode.show.rating_advanced ).not_to eql(nil)
            expect( episode.show.in_watchlist ).not_to eql(nil)

            expect( episode.episode.watched ).not_to eql(nil)
            expect( episode.episode.plays ).not_to eql(nil)
            expect( episode.episode.in_watchlist ).not_to eql(nil)
            expect( episode.episode.in_collection ).not_to eql(nil)
            expect( episode.episode.rating ).not_to eql(nil)
            expect( episode.episode.rating_advanced ).not_to eql(nil)
          end
        end
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#premieres' do
        expect { @trakt.calendar.premieres }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.calendar.shows }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end