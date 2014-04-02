require 'spec_helper'

describe Traktr::Movie do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#comments' do
        expect( @trakt.movie.comments('the-dark-knight-2008').size ).to be > 0
      end

      it '#summary' do
        expect( @trakt.movie.summary('the-dark-knight-2008').imdb_id ).to eql('tt0468569')
      end

      it '#summaries' do
        expect( @trakt.movie.summaries(['the-dark-knight-2008', 'the-social-network-2010']).size ).to eql(2)
      end

      it '#watchingnow' do
        expect( @trakt.movie.watchingnow('the-dark-knight-2008').size ).to be >= 0
      end

      it '#related' do
        expect( @trakt.movie.related('the-dark-knight-2008').size ).to eql(10)
      end

      it '#stats' do
        expect( @trakt.movie.stats('the-dark-knight-2008').class ).to eql(Mash)
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#comments' do
        expect { @trakt.movie.comments('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#summary' do
        expect { @trakt.movie.summary('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#summaries' do
        expect { @trakt.movie.summaries(['the-dark-knight-2008', 'the-social-network-2010']) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchingnow' do
        expect { @trakt.movie.watchingnow('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#related' do
        expect { @trakt.movie.related('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#stats' do
        expect { @trakt.movie.stats('the-dark-knight-2008').class }.to raise_error(Traktr::ResponseError)
      end
    end
  end
  context 'POST methods' do
    before :all do
      trakt = Traktr::Client.new(API_KEY)
      @movie = trakt.movie.summary('the-dark-knight-2008')
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#library' do
        expect( @trakt.movie.library(@movie).status ).to eql('success')
      end

      it '#unlibrary' do
        expect( @trakt.movie.unlibrary(@movie).status ).to eql('success')
      end

      it '#watchlist' do
        expect( @trakt.movie.watchlist(@movie).status ).to eql('success')
      end

      it '#unwatchlist' do
        expect( @trakt.movie.unwatchlist(@movie).status ).to eql('success')
      end

      it '#seen' do
        expect( @trakt.movie.seen(@movie).status ).to eql('success')
      end

      it '#unseen' do
        expect( @trakt.movie.unseen(@movie).status ).to eql('success')
      end

      it '#watching' do
        expect( @trakt.movie.watching(@movie, 85, "0.1", 'Dec 22 2013').status ).to eql('success')
      end

      it '#scrobble' do
        expect( @trakt.movie.scrobble(@movie, 85, "0.1", 'Dec 22 2013').status ).to eql('success')
      end

      it '#checkin' do
        expect( @trakt.movie.checkin(@movie, "0.1", "Dec 22 2013").status ).to eql('success')
      end

      it '#cancelwatching' do
        expect ( @trakt.movie.cancelwatching ).to eql('success')
      end
      
      it '#cancelcheckin' do
        expect ( @trakt.movie.cancelcheckin ).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil, USERNAME, PASSWORD)
      end

      it '#library' do
        expect { @trakt.movie.library(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { @trakt.movie.unlibrary(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { @trakt.movie.watchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { @trakt.movie.unwatchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.movie.seen(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect { @trakt.movie.unseen(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#watching' do
        expect { @trakt.movie.watching(@movie, 85, "0.1", 'Dec 22 2013') }.to raise_error(Traktr::ResponseError)
      end

      it '#scrobble' do
        expect { @trakt.movie.scrobble(@movie, 85, "0.1", 'Dec 22 2013') }.to raise_error(Traktr::ResponseError)
      end

      it '#checkin' do
        expect { @trakt.movie.checkin(@movie, "0.1", "Dec 22 2013") }.to raise_error(Traktr::ResponseError)
      end

      it '#cancelwatching' do
        expect { @trakt.movie.cancelwatching }.to raise_error(Traktr::ResponseError)
      end
      
      it '#cancelcheckin' do
        expect { @trakt.movie.cancelcheckin }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#library' do
        expect { @trakt.movie.library(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { @trakt.movie.unlibrary(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { @trakt.movie.watchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { @trakt.movie.unwatchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.movie.seen(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect { @trakt.movie.unseen(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#watching' do
        expect { @trakt.movie.watching(@movie, 85, "0.1", 'Dec 22 2013') }.to raise_error(Traktr::ResponseError)
      end

      it '#scrobble' do
        expect { @trakt.movie.scrobble(@movie, 85, "0.1", 'Dec 22 2013') }.to raise_error(Traktr::ResponseError)
      end

      it '#checkin' do
        expect { @trakt.movie.checkin(@movie, "0.1", "Dec 22 2013") }.to raise_error(Traktr::ResponseError)
      end

      it '#cancelwatching' do
        expect { @trakt.movie.cancelwatching }.to raise_error(Traktr::ResponseError)
      end
      
      it '#cancelcheckin' do
        expect { @trakt.movie.cancelcheckin }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end
