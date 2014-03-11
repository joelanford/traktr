require 'spec_helper'

describe Traktr::Activity do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      context 'with valid query' do
        it '#community' do
          expect( @trakt.activity.community.size ).to be > 0
        end

        it '#episodes' do
          expect( @trakt.activity.episodes('dexter', 1, 1).activity.class ).to eql(Array)
        end

        it '#movies' do
          expect( @trakt.activity.movies('the-dark-knight-2008').activity.class ).to eql(Array)
        end

        it '#seasons' do
          expect( @trakt.activity.seasons('dexter', 1).activity.class ).to eql(Array)
        end

        it '#shows' do
          expect( @trakt.activity.shows('dexter').activity.class ).to eql(Array)
        end

        it '#user' do
          expect( @trakt.activity.user('traktr').activity.class ).to eql(Array)
          expect( @trakt.activity.user('joe.lanford').status ).to eql("error")
        end
      end

      context 'with invalid query' do
        it '#episodes' do
          expect { @trakt.activity.episodes('blah', 1, 1) }.to raise_error(Traktr::ResponseError)
        end

        it '#movies' do
          expect { @trakt.activity.movies('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#seasons' do
          expect { @trakt.activity.seasons('blah', 1) }.to raise_error(Traktr::ResponseError)
        end

        it '#shows' do
          expect { @trakt.activity.shows('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#user' do
          expect { @trakt.activity.user('aaaaaaaaaaaaaaa') }.to raise_error(Traktr::ResponseError)
        end
      end

    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#community' do
        expect { @trakt.activity.community }.to raise_error(Traktr::ResponseError)
      end

      it '#episodes' do
        expect { @trakt.activity.episodes('dexter', 1, 1) }.to raise_error(Traktr::ResponseError)
      end

      it '#movies' do
        expect { @trakt.activity.movies('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#seasons' do
        expect { @trakt.activity.seasons('dexter', 1) }.to raise_error(Traktr::ResponseError)
      end

      it '#shows' do
        expect { @trakt.activity.shows('dexter') }.to raise_error(Traktr::ResponseError)
      end

      it '#user' do
        expect { @trakt.activity.user('traktr') }.to raise_error(Traktr::ResponseError)
      end
    end
  end

  context 'POST methods' do
    before :all do
      trakt = Traktr::Client.new(API_KEY)
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#friends' do
        expect( @trakt.activity.friends.activity.class ).to eql(Array)
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil, USERNAME, PASSWORD)
      end

      it '#friends' do
        expect { @trakt.activity.friends }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#friends' do
        expect { @trakt.activity.friends }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end