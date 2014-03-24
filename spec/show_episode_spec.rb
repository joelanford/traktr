require 'spec_helper'

describe Traktr::Show::Episode do
  context 'GET methods' do
    before :all do
      @show = 'the-walking-dead'
      @season = 1
      @episode = 1
    end

    after :all do
      @show = nil
      @season = nil
      @episode = nil
    end

    context 'with valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#comments' do
        expect( @trakt.show.episode.comments(@show, @season, @episode).size ).to be > 0
      end

      it '#stats' do
        expect( @trakt.show.episode.stats(@show, @season, @episode).keys.size ).to eql(8)
      end

      it '#summary' do
        expect( @trakt.show.episode.summary(@show, @season, @episode).show.imdb_id ).to eql('tt1520211')
      end

      it '#watchingnow' do
        expect( @trakt.show.episode.watchingnow(@show, @season, @episode).size ).to be >= 0
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil)
      end

      it '#comments' do
        expect { @trakt.show.episode.comments(@show, @season, @episode) }.to raise_error(Traktr::ResponseError)
      end

      it '#stats' do
        expect { @trakt.show.episode.stats(@show, @season, @episode) }.to raise_error(Traktr::ResponseError)
      end

      it '#summary' do
        expect { @trakt.show.episode.summary(@show, @season, @episode) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchingnow' do
        expect { @trakt.show.episode.watchingnow(@show, @season, @episode) }.to raise_error(Traktr::ResponseError)
      end
    end
  end

  context 'POST methods' do
    before :all do
      trakt = Traktr::Client.new(API_KEY)
      @show = trakt.show.summary('the-walking-dead')
      @episodes = trakt.show.season('the-walking-dead', 1)
    end

    context 'with valid api_key and auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY, USERNAME, PASSWORD)
      end

      it '#library' do
        expect( @trakt.show.episode.library(@show, @episodes).status ).to eql('success')
      end

      it '#unlibrary' do
        expect( @trakt.show.episode.unlibrary(@show, @episodes).status ).to eql('success')
      end

      it '#watchlist' do
        expect( @trakt.show.episode.watchlist(@show, @episodes).status ).to eql('success')
      end

      it '#unwatchlist' do
        expect( @trakt.show.episode.unwatchlist(@show, @episodes).status ).to eql('success')
      end

      it '#seen' do
        expect( @trakt.show.episode.seen(@show, @episodes).status ).to eql('success')
      end

      it '#unseen' do
        expect( @trakt.show.episode.unseen(@show, @episodes).status ).to eql('success')
      end
    end

    context 'without valid api_key' do
      before :all do
        @trakt = Traktr::Client.new(nil, USERNAME, PASSWORD)
      end

      it '#library' do
        expect { @trakt.show.episode.library(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { @trakt.show.episode.unlibrary(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { @trakt.show.episode.watchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { @trakt.show.episode.unwatchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.show.episode.seen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect { @trakt.show.episode.unseen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end
    end

    context 'without valid auth credentials' do
      before :all do
        @trakt = Traktr::Client.new(API_KEY)
      end

      it '#library' do
        expect { @trakt.show.episode.library(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { @trakt.show.episode.unlibrary(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { @trakt.show.episode.watchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { @trakt.show.episode.unwatchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { @trakt.show.episode.seen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect { @trakt.show.episode.unseen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end