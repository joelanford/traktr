require 'spec_helper'

describe Traktr::Show do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      context 'with valid query' do
        it '#comments' do
          expect( @trakt.show.comments('dexter').size ).to be > 0
        end

        it '#season' do
          expect( @trakt.show.season('dexter', 1).size ).to eql(12)
        end

        it '#seasons' do
          expect( @trakt.show.seasons('dexter').size ).to eql(9)
        end

        it '#summary' do
          expect( @trakt.show.summary('dexter').imdb_id ).to eql('tt0773262')
        end

        it '#summaries' do
          expect( @trakt.show.summaries(['dexter', 'the-walking-dead']).size ).to eql(2)
        end

        it '#watchingnow' do
          expect( @trakt.show.watchingnow('dexter').size ).to be >= 0
        end

        it '#related' do
          expect( @trakt.show.related('dexter').size ).to eql(10)
        end
      end

      context 'with invalid query' do
        it '#comments' do
          expect { @trakt.show.comments('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#season' do
          expect { @trakt.show.season('blah', 1) }.to raise_error(Traktr::ResponseError)
          expect { @trakt.show.season('dexter') }.to raise_error(ArgumentError)
        end

        it '#seasons' do
          expect { @trakt.show.seasons('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#summary' do
          expect { @trakt.show.summary('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#summaries' do
          expect { @trakt.show.summaries(['blah', 'blah-blah']) }.to raise_error(Traktr::ResponseError)
        end

        it '#watchingnow' do
          expect { @trakt.show.watchingnow('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#related' do
          expect { @trakt.show.related('blah') }.to raise_error(Traktr::ResponseError)
        end
      end

    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#comments' do
        expect { @trakt.show.comments('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#season' do
        expect { @trakt.show.season('the-walking-dead', 1) }.to raise_error(Traktr::ResponseError)
      end

      it '#seasons' do
        expect { @trakt.show.seasons('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#summary' do
        expect { @trakt.show.summary('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#summaries' do
        expect { @trakt.show.summaries(['the-walking-dead', 'dexter']) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchingnow' do
        expect { @trakt.show.watchingnow('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#related' do
        expect { @trakt.show.related('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end
    end
  end

  context 'POST methods' do
    before :all do
      trakt = Traktr::Client.new(API_KEY)
      @show = trakt.show.summary('dexter')
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#library' do
        expect( @trakt.show.library(@show).status ).to eql('success')
      end

      it '#unlibrary' do
        expect( @trakt.show.unlibrary(@show).status ).to eql('success')
      end

      it '#watchlist' do
        expect( @trakt.show.watchlist(@show).status ).to eql('success')
      end

      it '#unwatchlist' do
        expect( @trakt.show.unwatchlist(@show).status ).to eql('success')
      end

      it '#seen' do
        expect( @trakt.show.seen(@show).status ).to eql('success')
      end

      it '#scrobble' do
        expect( @trakt.show.scrobble(@show, 1, 1, 85, "0.1", 'Dec 22 2013').status ).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil, USERNAME, PASSWORD)
      end

      it '#library' do
        expect { @trakt.show.library(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { @trakt.show.unlibrary(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { @trakt.show.watchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { @trakt.show.unwatchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.show.seen(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#scrobble' do
        expect { @trakt.show.scrobble(@show, 1, 1, 85, "0.1", 'Dec 22 2013') }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#library' do
        expect { @trakt.show.library(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { @trakt.show.unlibrary(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { @trakt.show.watchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { @trakt.show.unwatchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.show.seen(@show) }.to raise_error(Traktr::ResponseError)
      end
      
      it '#scrobble' do
        expect { @trakt.show.scrobble(@show, 1, 1, 85, "0.1", "Dec 22 2013") }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
