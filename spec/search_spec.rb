require 'spec_helper'

describe Traktr::Search do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#episodes' do
        expect( @trakt.search.episodes('warfare').size ).to be > 0
      end

      it '#movies' do
        expect( @trakt.search.movies('Batman').size ).to be > 0
      end

      it '#people' do
        expect( @trakt.search.people('christian bale').size ).to be > 0
      end

      it '#shows' do
        expect( @trakt.search.shows('big bang theory').size ).to be > 0
      end

      it '#users' do
        expect( @trakt.search.users('justin').size ).to be > 0
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#episodes' do
        expect { @trakt.search.episodes('warfare') }.to raise_error(Traktr::ResponseError)
      end

      it '#movies' do
        expect { @trakt.search.movies('Batman') }.to raise_error(Traktr::ResponseError)
      end

      it '#people' do
        expect { @trakt.search.people('christian bale') }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.search.shows('big bang theory') }.to raise_error(Traktr::ResponseError)
      end

      it '#users' do
        expect { @trakt.search.users('justin') }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end