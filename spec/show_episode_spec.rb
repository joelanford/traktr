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
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      it '#comments' do
        comments = Traktr::Show::Episode.comments(@show, @season, @episode)
        expect(comments.size).to be > 0
      end

      it '#summary' do
        summary = Traktr::Show::Episode.summary(@show, @season, @episode)
        expect(summary.show.imdb_id).to eql('tt1520211')
      end

      it '#watchingnow' do
        watchingnow = Traktr::Show::Episode.watchingnow(@show, @season, @episode)
        expect(watchingnow.size).to be >= 0
      end

    end

    context 'without valid api_key' do
      it '#comments' do
        expect { comments = Traktr::Show::Episode.comments(@show, @season, @episode) }.to raise_error(Traktr::ResponseError)
      end

      it '#summary' do
        expect { summary = Traktr::Show::Episode.summary(@show, @season, @episode) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchingnow' do
        expect { watchingnow = Traktr::Show::Episode.watchingnow(@show, @season, @episode) }.to raise_error(Traktr::ResponseError)
      end
    end
  end

  context 'POST methods' do
    before :all do
      Traktr.api_key  = API_KEY
      @show = Traktr::Show.summary('the-walking-dead')
      @episodes = Traktr::Show.season('the-walking-dead', 1)
      Traktr.api_key  = ''
    end

    after :all do
      @show = nil
      @episodes = nil
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
        expect(Traktr::Show::Episode.library(@show, @episodes).status).to eql('success')
      end

      it '#unlibrary' do
        expect(Traktr::Show::Episode.unlibrary(@show, @episodes).status).to eql('success')
      end

      it '#watchlist' do
        expect(Traktr::Show::Episode.watchlist(@show, @episodes).status).to eql('success')
      end

      it '#unwatchlist' do
        expect(Traktr::Show::Episode.unwatchlist(@show, @episodes).status).to eql('success')
      end

      it '#seen' do
        expect(Traktr::Show::Episode.seen(@show, @episodes).status).to eql('success')
      end

      it '#unseen' do
        expect(Traktr::Show::Episode.unseen(@show, @episodes).status).to eql('success')
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
        expect { comments = Traktr::Show::Episode.library(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { season = Traktr::Show::Episode.unlibrary(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { seasons = Traktr::Show::Episode.watchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { seasons = Traktr::Show::Episode.unwatchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { summary = Traktr::Show::Episode.seen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect { summary = Traktr::Show::Episode.unseen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
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
        expect { comments = Traktr::Show::Episode.library(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { season = Traktr::Show::Episode.unlibrary(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { seasons = Traktr::Show::Episode.watchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { seasons = Traktr::Show::Episode.unwatchlist(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { summary = Traktr::Show::Episode.seen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end

      it '#unseen' do
        expect { summary = Traktr::Show::Episode.unseen(@show, @episodes) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end