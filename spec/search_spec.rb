require 'spec_helper'

describe Traktr::Search do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#episodes' do
        results = Traktr::Search.episodes('warfare')
        expect(results.size).to be > 0
      end

      it '#movies' do
        results = Traktr::Search.movies('Batman')
        expect(results.size).to be > 0
      end

      it '#people' do
        results = Traktr::Search.people('christian bale')
        expect(results.size).to be > 0
      end

      it '#shows' do
        results = Traktr::Search.shows('big bang theory')
        expect(results.size).to be > 0
      end

      it '#users' do
        results = Traktr::Search.users('justin')
        expect(results.size).to be > 0
      end
    end

    context 'without valid api_key' do
      it '#episodes' do
        expect { Traktr::Search.episodes('warfare') }.to raise_error(Traktr::ResponseError)
      end

      it '#movies' do
        expect { Traktr::Search.movies('Batman') }.to raise_error(Traktr::ResponseError)
      end

      it '#people' do
        expect { Traktr::Search.people('christian bale') }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { Traktr::Search.shows('big bang theory') }.to raise_error(Traktr::ResponseError)
      end

      it '#users' do
        expect { Traktr::Search.users('justin') }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end