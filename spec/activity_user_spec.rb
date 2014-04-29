require 'spec_helper'

describe Traktr::Activity::User do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      context 'with valid query' do
        it '#episodes' do
          expect(@trakt.activity.user.episodes('traktr', 'dexter', 1, 1).activity.class).to eql(Array)
        end

        it '#movies' do
          expect(@trakt.activity.user.movies('traktr', 'the-dark-knight-2008').activity.class).to eql(Array)
        end

        it '#seasons' do
          expect(@trakt.activity.user.seasons('traktr', 'dexter', 1).activity.class).to eql(Array)
        end

        it '#shows' do
          expect(@trakt.activity.user.shows('traktr', 'dexter').activity.class).to eql(Array)
        end
      end

      context 'with invalid query' do
        it '#episodes' do
          expect { @trakt.activity.user.episodes('traktr', 'blah', 1, 1) }.to raise_error(Traktr::ResponseError)
        end

        it '#movies' do
          expect { @trakt.activity.user.movies('traktr', 'blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#seasons' do
          expect { @trakt.activity.user.seasons('traktr', 'blah', 1) }.to raise_error(Traktr::ResponseError)
        end

        it '#shows' do
          expect { @trakt.activity.user.shows('traktr', 'blah') }.to raise_error(Traktr::ResponseError)
        end
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#episodes' do
        expect { @trakt.activity.user.episodes('traktr', 'dexter', 1, 1) }.to raise_error(Traktr::ResponseError)
      end

      it '#movies' do
        expect { @trakt.activity.user.movies('traktr', 'the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#seasons' do
        expect { @trakt.activity.user.seasons('traktr', 'dexter', 1) }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.activity.user.shows('traktr', 'dexter') }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
