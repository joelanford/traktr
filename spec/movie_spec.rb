require 'spec_helper'

describe Traktr::Movie do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#comments' do
        comments = Traktr::Movie.comments('the-dark-knight-2008')
        expect(comments.size).to be > 0
      end

      it '#summary' do
        summary = Traktr::Movie.summary('the-dark-knight-2008')
        expect(summary.imdb_id).to eql('tt0468569')
      end

      it '#summaries' do
        summaries = Traktr::Movie.summaries(['the-dark-knight-2008', 'the-social-network-2010'])
        expect(summaries.size).to eql(2)
      end

      it '#watchingnow' do
        watchingnow = Traktr::Movie.watchingnow('the-dark-knight-2008')
        expect(watchingnow.size).to be >= 0
      end

      it '#related' do
        related = Traktr::Movie.related('the-dark-knight-2008')
        expect(related.size).to eql(10)
      end
    end

    context 'without valid api_key' do
      it '#comments' do
        expect { comments = Traktr::Movie.comments('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#summary' do
        expect {Traktr::Movie.summary('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#summaries' do
        expect { summaries = Traktr::Movie.summaries(['the-dark-knight-2008', 'the-social-network-2010']) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchingnow' do
        expect { watchingnow = Traktr::Movie.watchingnow('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end

      it '#related' do
        expect { related = Traktr::Movie.related('the-dark-knight-2008') }.to raise_error(Traktr::ResponseError)
      end
    end
  end
  context 'POST methods' do
    before :all do
      Traktr.api_key = API_KEY
      @movie = Traktr::Movie.summary('the-dark-knight-2008')
      Traktr.api_key = ''
    end

    after :all do
      @movie = nil
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        Traktr.api_key  = API_KEY
        Traktr.username = USERNAME
        Traktr.password = PASSWORD
      end

      after :all do
        Traktr.api_key  = ''
        Traktr.username = ''
        Traktr.password = ''
      end

      it '#library' do
        expect(Traktr::Movie.library(@movie).status).to eql('success')
      end

      it '#unlibrary' do
        expect(Traktr::Movie.unlibrary(@movie).status).to eql('success')
      end

      it '#watchlist' do
        expect(Traktr::Movie.watchlist(@movie).status).to eql('success')
      end

      it '#unwatchlist' do
        expect(Traktr::Movie.unwatchlist(@movie).status).to eql('success')
      end

      it '#seen' do
        expect(Traktr::Movie.seen(@movie).status).to eql('success')
      end

      it '#unseen' do
        expect(Traktr::Movie.unseen(@movie).status).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        Traktr.username = USERNAME
        Traktr.password = PASSWORD
      end

      after :all do
        Traktr.username = ''
        Traktr.password = ''
      end

      it '#library' do
        expect {Traktr::Movie.library(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect {Traktr::Movie.unlibrary(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect {Traktr::Movie.watchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect {Traktr::Movie.unwatchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect {Traktr::Movie.seen(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect {Traktr::Movie.unseen(@movie) }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#library' do
        expect {Traktr::Movie.library(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect {Traktr::Movie.unlibrary(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect {Traktr::Movie.watchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect {Traktr::Movie.unwatchlist(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect {Traktr::Movie.seen(@movie) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect {Traktr::Movie.unseen(@movie) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end