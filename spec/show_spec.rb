require 'spec_helper'

describe Traktr::Show do
  context 'GET methods' do
    context 'with valid api_key' do
      before :all do
        Traktr.api_key = API_KEY
      end

      after :all do
        Traktr.api_key = ''
      end

      context 'with valid query' do
        it '#comments' do
          comments = Traktr::Show.comments('dexter')
          expect(comments.size).to be > 0
        end

        it '#season' do
          season = Traktr::Show.season('dexter', 1)
          expect(season.size).to eql(12)
        end

        it '#seasons' do
          seasons = Traktr::Show.seasons('dexter')
          expect(seasons.size).to eql(9)
        end

        it '#summary' do
          summary = Traktr::Show.summary('dexter')
          expect(summary.imdb_id).to eql('tt0773262')
        end

        it '#summaries' do
          summaries = Traktr::Show.summaries(['dexter', 'the-walking-dead'])
          expect(summaries.size).to eql(2)
        end

        it '#watchingnow' do
          watchingnow = Traktr::Show.watchingnow('dexter')
          expect(watchingnow.size).to be >= 0
        end

        it '#related' do
          related = Traktr::Show.related('dexter')
          expect(related.size).to eql(10)
        end
      end

      context 'with invalid query' do
        it '#comments' do
          expect { comments = Traktr::Show.comments('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#season' do
          expect { season = Traktr::Show.season('blah', 1) }.to raise_error(Traktr::ResponseError)
        end

        it '#seasons' do
          expect { seasons = Traktr::Show.seasons('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#summary' do
          expect { summary = Traktr::Show.summary('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#summaries' do
          expect { summaries = Traktr::Show.summaries(['blah', 'blah-blah']) }.to raise_error(Traktr::ResponseError)
        end

        it '#watchingnow' do
          expect { watchingnow = Traktr::Show.watchingnow('blah') }.to raise_error(Traktr::ResponseError)
        end

        it '#related' do
          expect { related = Traktr::Show.related('blah') }.to raise_error(Traktr::ResponseError)
        end
      end

    end

    context 'without valid api_key' do
      it '#comments' do
        expect { comments = Traktr::Show.comments('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#season' do
        expect { season = Traktr::Show.season('the-walking-dead', 1) }.to raise_error(Traktr::ResponseError)
      end

      it '#seasons' do
        expect { seasons = Traktr::Show.seasons('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#summary' do
        expect { summary = Traktr::Show.summary('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#summaries' do
        expect { summaries = Traktr::Show.summaries(['the-walking-dead', 'dexter']) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchingnow' do
        expect { watchingnow = Traktr::Show.watchingnow('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end

      it '#related' do
        expect { related = Traktr::Show.related('the-walking-dead') }.to raise_error(Traktr::ResponseError)
      end
    end
  end

  context 'POST methods' do
    before :all do
      Traktr.api_key = API_KEY
      @show = Traktr::Show.summary('dexter')
      Traktr.api_key = ''
    end

    after :all do
      @show = nil
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
        expect(Traktr::Show.library(@show).status).to eql('success')
      end

      it '#unlibrary' do
        expect(Traktr::Show.unlibrary(@show).status).to eql('success')
      end

      it '#watchlist' do
        expect(Traktr::Show.watchlist(@show).status).to eql('success')
      end

      it '#unwatchlist' do
        expect(Traktr::Show.unwatchlist(@show).status).to eql('success')
      end

      it '#seen' do
        expect(Traktr::Show.seen(@show).status).to eql('success')
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
        expect { comments = Traktr::Show.library(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { season = Traktr::Show.unlibrary(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { seasons = Traktr::Show.watchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { seasons = Traktr::Show.unwatchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { summary = Traktr::Show.seen(@show) }.to raise_error(Traktr::ResponseError)
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
        expect { comments = Traktr::Show.library(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unlibrary' do
        expect { season = Traktr::Show.unlibrary(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#watchlist' do
        expect { seasons = Traktr::Show.watchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#unwatchlist' do
        expect { seasons = Traktr::Show.unwatchlist(@show) }.to raise_error(Traktr::ResponseError)
      end

      it '#seen' do
        expect { summary = Traktr::Show.seen(@show) }.to raise_error(Traktr::ResponseError)
      end
    end
  end
end